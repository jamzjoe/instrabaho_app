import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/domain/data/worker_model.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/search_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/percent_indicator.dart';

class JobMapFinderScreen extends StatefulWidget {
  const JobMapFinderScreen({super.key});

  @override
  State<JobMapFinderScreen> createState() => _JobMapFinderScreenState();
}

class _JobMapFinderScreenState extends State<JobMapFinderScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  String? _mapStyle;

  @override
  void initState() {
    super.initState();
    // Load the map style JSON
    // loadMapStyle().then((style) {
    //   setState(() {
    //     _mapStyle = style;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
          padding: const EdgeInsets.all(16.0), // Add padding here
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              final findingPercentage = state.findingPercentage;
              final workerIsOnTheWayPercentage =
                  state.workerIsOnTheWayPercentage;
              final completedPercentage = state.completedPercentage;
              final workingPercentage = state.workingPercentage;
              final iconWidth = 20.0;
              final status = state.jobSearchStatus;
              final bool isFindingDone = findingPercentage == 1.0;
              final bool isWorkerIsOnTheWayDone =
                  workerIsOnTheWayPercentage == 1.0;
              final bool isWorkingDone = workingPercentage == 1.0;
              final bool isCompletedDone = completedPercentage == 1.0;
              final activeQuery = state.activeHint;
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isCompletedDone)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LinearPercentIndicator(
                          linearGradient: LinearGradient(
                            colors: [
                              secondaryColor,
                              secondaryColor.withOpacity(isFindingDone ? 1 : 0),
                            ],
                          ),
                          barRadius: Radius.circular(8),
                          padding: EdgeInsets.symmetric(horizontal: 1.0),
                          width: MediaQuery.of(context).size.width - 32,
                          lineHeight: 14.0,
                          percent: findingPercentage,
                          backgroundColor: hintColor.withOpacity(0.5),
                          // progressColor: buttonColor,
                        ),
                      ],
                    ),
                  if (status == JobSearchStatus.finding && !isFindingDone)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Finding ${activeQuery.isNotEmpty && isVowel(activeQuery[0]) ? 'an' : 'a'} $activeQuery for you...',
                          style: context.textTheme.labelSmall,
                        ),
                      ),
                    ),
                  if (isFindingDone)
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              '${capitalizeEachWord(activeQuery)} near you (${state.workers?.length} out of 10)',
                              style: context.textTheme.caption),
                          if (state.workers != null ||
                              state.workers?.isNotEmpty == true)
                            ...state.workers!.map((worker) {
                              return Worker(
                                worker: worker,
                                onTap: () {
                                  _reviewProfile(worker);
                                },
                              );
                            }),
                          Gap(10),
                          InstrabahoButton(
                              label: "Find more",
                              onTap: () {
                                BlocProvider.of<SearchBloc>(context)
                                    .add(SearchJobFindWorker());
                              }),
                        ],
                      ),
                    ),
                  if (isCompletedDone)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20),
                        //check icon
                        Center(
                          child: Icon(Ionicons.checkmark_done_circle,
                              color: Colors.green, size: 60),
                        ),
                        Center(
                          child: Text('Job completed',
                              style: context.textTheme.labelLarge),
                        ),
                        //rate
                        Gap(20),
                        Text('Rate your worker',
                            style: context.textTheme.labelMedium),
                        Gap(10),
                        //star rating row 5 stars
                        Row(children: [
                          ...List.generate(5, (index) {
                            return Icon(Ionicons.star,
                                color: Colors.grey.shade200, size: 30);
                          }),
                        ]),
                        Gap(20),
                        //review
                        Text('Review your worker',
                            style: context.textTheme.labelMedium),
                        Gap(10),
                        InstrabahoTextField(
                          hintText: 'Write your review here',
                        ),
                        Gap(20),
                        InstrabahoButton(
                            label: 'Submit review',
                            onTap: () {
                              GoRouter.of(context).pop();
                            }),
                        Gap(10),
                        InstrabahoButton(
                          label: 'Close',
                          outline: true,
                          onTap: () {
                            GoRouter.of(context).pop();
                          },
                        )
                      ],
                    ),
                  Gap(50)
                ],
              );
            },
          ),
        ),
        body: Container(
          child: GoogleMap(
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(14.599512, 120.984222), zoom: 15)),
        ));
  }

  // Future<String> loadMapStyle() async {
  //   // Load the JSON file as a string
  //   return await rootBundle.loadString('lib/constants/map_style.json');
  // }

  isVowel(String activeQuery) {
    return activeQuery.toLowerCase().startsWith(RegExp(r'[aeiou]'));
  }

  void _reviewProfile(WorkerModel worker) {
    BlocProvider.of<SearchBloc>(context).add(SearchSetActiveWorker(worker));
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          var height = MediaQuery.of(context).size.height * 0.8;
          //user profile
          return ProfileBottomSheet(height: height, worker: worker);
        });
  }
}

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({
    super.key,
    required this.worker,
    required this.height,
  });
  final WorkerModel worker;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Column(
                  children: [
                    Text('${worker.position}\'s Profile',
                        style: context.textTheme.subTitle,
                        textAlign: TextAlign.center),

                    //availability days and time
                    Text('Available Mon-Fri 8am-5pm',
                        style: context.textTheme.hintStyle
                            .copyWith(color: Colors.green)),
                  ],
                ),
              ),
              Gap(10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text('John Doe',
                            style: context.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                      Center(
                          child: Text('${worker.location}',
                              style: context.textTheme.hintStyle)),
                    ],
                  ),
                  Spacer(),
                  Center(child: CircleAvatar(radius: 30)),
                ],
              ),
              //star rating row 5 stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(5, (index) {
                    return Icon(Ionicons.star,
                        color: const Color.fromARGB(255, 240, 161, 42),
                        size: 20);
                  }),
                ],
              ),
              Gap(10),
              Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('4.8 out of 5',
                      style: context.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Text('100 reviews', style: context.textTheme.hintStyle),
                ],
              )),
              Gap(30),
              //handshake icon with text "make a deal"
              GestureDetector(
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                  context.pushNamed(RouterNames.messageConversation,
                      extra: worker);
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //call icon
                      CircleAvatar(
                        backgroundColor: Colors.green.withOpacity(0.5),
                        radius: 30,
                        child: CircleAvatar(
                            backgroundColor: Colors.green.withOpacity(1),
                            radius: 20,
                            child: Icon(Ionicons.chatbox,
                                color: Colors.white, size: 15)),
                      ),
                      Gap(10),
                      Text('Make a deal', style: context.textTheme.hintStyle),
                    ],
                  ),
                ),
              ),

              Text('Bio', style: context.textTheme.noteStyle),
              Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit  sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: context.textTheme.labelSmall),
              Gap(15),
              Text('Skills', style: context.textTheme.noteStyle),
              Text('Plumbing, Electrical Work',
                  style: context.textTheme.labelSmall),
              Gap(15),
              Text('Certifications', style: context.textTheme.noteStyle),
              Text('Certified Plumber, Licensed Electrician',
                  style: context.textTheme.labelSmall),
              Gap(15),
              Text('Rates', style: context.textTheme.noteStyle),
              Text('\$50/hour', style: context.textTheme.labelSmall),
              Gap(15),
              Text('Member since', style: context.textTheme.noteStyle),
              Text('December 30, 1999', style: context.textTheme.labelSmall),
              Gap(15),
              //gallery
              Text('Recent Jobs Gallery', style: context.textTheme.noteStyle),
              Gap(10),
              Container(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child:
                                Icon(Icons.add_a_photo, color: Colors.white)),
                      );
                    }),
              ),
              Gap(20),
              InstrabahoButton(
                  label: 'Hire ${worker.name} as your ${worker.position}',
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                    context.pushNamed(RouterNames.messageConversation,
                        extra: worker);
                  }),
            ]),
      ),
    );
  }
}

class Worker extends StatelessWidget {
  const Worker({super.key, required this.worker, required this.onTap});

  final WorkerModel worker;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            CircleAvatar(),
            Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${worker.name}', style: context.textTheme.labelMedium),
                  Text('${worker.position}',
                      style:
                          context.textTheme.noteStyle.copyWith(fontSize: 12)),
                  Text('${worker.location}')
                ],
              ),
            ),

            //chat button
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Ionicons.star, color: Colors.yellow),
                    Gap(5),
                    Text('4.5', style: context.textTheme.labelSmall),
                    Gap(10),
                    Text('100 reviews', style: context.textTheme.labelSmall),
                  ],
                ),
                //availability
                Row(
                  children: [
                    //online icon
                    Icon(Ionicons.checkmark_circle,
                        color: Colors.green, size: 15),
                    Gap(5),
                    Text('Available', style: context.textTheme.labelSmall),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
