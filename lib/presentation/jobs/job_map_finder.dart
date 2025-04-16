import 'dart:async';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:instrabaho_app/constant/data/certificate_mock_data.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/domain/data/worker_model.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/search_bloc.dart';
import 'package:instrabaho_app/presentation/messages/bloc/message_bloc.dart';
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
                              C.blue600,
                              C.blue600.withOpacity(isFindingDone ? 1 : 0),
                            ],
                          ),
                          barRadius: Radius.circular(8),
                          padding: EdgeInsets.symmetric(horizontal: 1.0),
                          width: MediaQuery.of(context).size.width - 32,
                          lineHeight: 14.0,
                          percent: findingPercentage,
                          backgroundColor: C.hintColor.withOpacity(0.5),
                          // progressColor: buttonColor,
                        ),
                      ],
                    ),
                  if (status == JobSearchStatus.finding && !isFindingDone)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Gap(20),
                            Text(
                                'Hang tight! We are finding an amazing $activeQuery for you...',
                                style: context.textTheme.labelSmall),
                            Gap(20),
                            Text(
                                "Workers might need time to accept your job request",
                                style: context.textTheme.noteStyle
                                    .copyWith(fontSize: 12)),
                            Gap(20),
                            InstrabahoButton(
                                label: "Cancel job request",
                                onTap: () {
                                  GoRouter.of(context).pop();
                                }),
                          ],
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
    showFlexibleBottomSheet(
        minHeight: .9,
        maxHeight: .5,
        initHeight: .9,
        context: context,
        builder: (context, scrollController, bottomSheetOffset) {
          var height = MediaQuery.of(context).size.height * 0.8;
          //user profile
          return ProfileBottomSheet(
              height: height,
              worker: worker,
              scrollController: scrollController);
        });
  }
}

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet(
      {super.key,
      required this.worker,
      required this.height,
      required this.scrollController});
  final WorkerModel worker;
  final double height;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          // Scrollable content
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.only(
                      bottom: 80), // Leave space for the bottom container
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //close icon
                                GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).pop();
                                  },
                                  child: Icon(Ionicons.close,
                                      color: Colors.grey, size: 25),
                                ),
                                Text("Worker's Profile",
                                    style: context.textTheme.subTitle,
                                    textAlign: TextAlign.center),
                                Gap(25)
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 20,
                          thickness: .5,
                          color: C.hintColor,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(radius: 50), //worker image
                                  Gap(10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${worker.name}',
                                          style: context.textTheme.nameStyle),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: C.blue700.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(80)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        child: Text('${worker.position}',
                                            style: context.textTheme.noteStyle
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: C.blue700)),
                                      ),
                                      Gap(5),
                                      Row(
                                        children: [
                                          ...List.generate(
                                            5,
                                            (index) => Icon(
                                              Ionicons.star,
                                              color: Color(0xffF57E20),
                                              size: 15,
                                            ),
                                          ),
                                          Gap(5),
                                          Text('4.5',
                                              style:
                                                  context.textTheme.labelSmall),
                                        ],
                                      ),
                                      Gap(10),
                                      IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Icon(Ionicons.location_outline,
                                                size: 15),
                                            Text('${worker.location}',
                                                style: context
                                                    .textTheme.noteStyle),
                                            //vertical divider
                                            VerticalDivider(
                                              color: C.hintColor,
                                              thickness: 1,
                                              width: 20,
                                            ),
                                            Text('0.5 km away',
                                                style: context
                                                    .textTheme.noteStyle),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Gap(24),
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: _boxDecor(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Skills",
                                        style: context.textTheme.labelMedium),
                                    Gap(10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: [
                                          ...List.generate(
                                            10,
                                            (index) => Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffF57E20)
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          80)),
                                              child: Text('Skill $index',
                                                  style: context
                                                      .textTheme.noteStyle),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(24),
                              //certifications and trainings
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: _boxDecor(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Certifications and Trainings",
                                        style: context.textTheme.labelMedium),
                                    Gap(10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: [
                                          ...certificateList.map((certificate) {
                                            return Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: C.hintColor
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          80)),
                                              child: Text(
                                                  '${certificate.title}',
                                                  style: context
                                                      .textTheme.noteStyle),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Fixed container at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ]),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Worker's offer",
                          style: context.textTheme.subheader,
                        ),
                        Spacer(),
                        Text(
                          "₱ 500",
                          style: context.textTheme.subheader,
                        ),
                      ],
                    ),
                    Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: InstrabahoButton(
                            outline: true,
                            borderColor: C.blue600,
                            bgColor: Colors.transparent,
                            label: "Mesage",
                            onTap: () {
                              BlocProvider.of<MessageBloc>(context)
                                  .add(MessageInit(worker: worker));
                              GoRouter.of(context).pushNamed(
                                  RouterNames.messageConversation,
                                  extra: WorkerModel(
                                      name: 'John Doe',
                                      position: 'Plumbing',
                                      rating: 4.5));
                            },
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          child: InstrabahoButton(
                            label: "Hire now",
                            onTap: () {
                              showFlexibleBottomSheet(
                                minHeight: .2,
                                maxHeight: .5,
                                initHeight: .45,
                                bottomSheetColor: Colors.white,
                                bottomSheetBorderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                context: context,
                                builder: (context, scrollController,
                                    bottomSheetOffset) {
                                  return Stack(
                                    children: [
                                      // Scrollable content
                                      Column(
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              controller: scrollController,
                                              child: Container(
                                                padding: EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    // Fake drag handle
                                                    Container(
                                                      width: 40,
                                                      height: 5,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(80),
                                                      ),
                                                    ),
                                                    Gap(10),
                                                    Text(
                                                        "Confirm your hiring details",
                                                        style: context.textTheme
                                                            .subTitle),
                                                    Gap(20),
                                                    PaymentDetailRow(
                                                        label: "Worker's name",
                                                        value: 'John Doe'),
                                                    PaymentDetailRow(
                                                        label: "Payment type",
                                                        value: 'Cash'),
                                                    PaymentDetailRow(
                                                        label: "Base price",
                                                        value: '₱ 500'),
                                                    PaymentDetailRow(
                                                        label:
                                                            "Convenience fee",
                                                        value: '₱ 50'),
                                                    Gap(20),
                                                    // Total
                                                    Row(
                                                      children: [
                                                        Text("Total",
                                                            style: context
                                                                .textTheme
                                                                .subTitle),
                                                        Spacer(),
                                                        Text("₱ 550",
                                                            style: context
                                                                .textTheme
                                                                .subTitle),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Bottom button
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: InstrabahoButton(
                                            label: "Hire worker",
                                            onTap: () {
                                              GoRouter.of(context).pushNamed(
                                                  RouterNames
                                                      .jobConfirmedScreen);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecor() {
    return BoxDecoration(
        border: Border.all(color: C.hintColor),
        borderRadius: BorderRadius.circular(8));
  }
}

class PaymentDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const PaymentDetailRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            label,
            style: context.textTheme.defaultBold,
          ),
          Spacer(),
          Text(
            value,
            style: context.textTheme.defaultBold,
          ),
        ],
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
                  Gap(5),
                  Text('${worker.position}',
                      style:
                          context.textTheme.noteStyle.copyWith(fontSize: 12)),
                  Gap(5),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          Ionicons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                      ),
                    ],
                  )
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
