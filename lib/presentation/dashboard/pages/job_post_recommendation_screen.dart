import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/domain/data/worker_model.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/job_post_bloc.dart';
import 'package:instrabaho_app/presentation/dashboard/pages/job_post_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../jobs/job_map_finder.dart';

class JobPostRecommendationScreen extends StatelessWidget {
  const JobPostRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarSize = AppBar().preferredSize.height;

    return BlocBuilder<JobPostBloc, JobPostState>(
      builder: (context, state) {
        final loadingStatus = state.jobPostSearchingStatus;
        final isLoading = loadingStatus == JobPostSearchingStatus.searching;
        return Scaffold(
          //cancel button
          bottomNavigationBar: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            margin: EdgeInsets.only(bottom: 20),
            child: InstrabahoButton(
                bgColor: C.cancelColor,
                width: double.infinity,
                hugContent: true,
                label: 'Cancel'),
          ),
          body: isLoading
              ? _RecommendedJobShimmer()
              : _RecommendedJobs(appBarSize: appBarSize),
        );
      },
    );
  }
}

class _RecommendedJobShimmer extends StatelessWidget {
  const _RecommendedJobShimmer();

  @override
  Widget build(BuildContext context) {
    final appBarSize = AppBar().preferredSize.height;

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(appBarSize),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Finding the best workers for you...",
                    style: context.textTheme.subTitle),
                Text(
                    "Hang tight! We're matching your job with skilled and trusted workers nearby",
                    style: context.textTheme.noteStyle),
              ],
            ),
          ),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 2.5),
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RecommendedJobs extends StatelessWidget {
  const _RecommendedJobs({
    required this.appBarSize,
  });

  final double appBarSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(appBarSize),
        CustomBackButton(
          onTap: () {
            context.pop();
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Recommended Workers", style: context.textTheme.subTitle),
              Text(
                  "Here are the best workers for your job based on your preferences.",
                  style: context.textTheme.noteStyle),
            ],
          ),
        ),
        // chip drowdown filter filter icon, price text with dropdown icon, location text with dropdown icon, and rating text with dropdown icon
        Gap(16),
        SingleChildScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Gap(16),
              _ChipDropdownFilter(
                label: "",
                icon: SvgPicture.asset(Assets.icon.filterIcon),
                options: [],
              ),
              Gap(16),
              _ChipDropdownFilter(
                  label: "Price",
                  icon: Icon(Icons.keyboard_arrow_down, size: 22),
                  options: [
                    "Low to High",
                    "High to Low",
                  ]),
              Gap(16),
              _ChipDropdownFilter(
                label: "Location",
                icon: Icon(Icons.keyboard_arrow_down, size: 22),
                options: [
                  "Nearby",
                  "Far",
                ],
              ),
              Gap(16),
              _ChipDropdownFilter(
                  label: "Rating",
                  icon: Icon(Icons.keyboard_arrow_down, size: 22),
                  options: [
                    "Low to High",
                    "High to Low",
                  ]),
            ],
          ),
        ),
        Gap(16),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: .65,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return Animate(
                effects: [
                  FadeEffect(
                    delay: Duration(milliseconds: index * 100),
                    duration: Duration(milliseconds: 500),
                  ),
                  ScaleEffect(
                    delay: Duration(milliseconds: index * 100),
                    duration: Duration(milliseconds: 500),
                  ),
                ],
                delay: Duration(milliseconds: index * 100),
                child: InkWell(
                  onTap: () {
                    final worker = WorkerModel(
                      name: "Name",
                      rating: 4.5,
                      bio: "Bio",
                      position: 'Position',
                      location: "Location",
                    );
                    _reviewProfile(worker, context: context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: index == 0
                          ? GradientBoxBorder(
                              width: 2,
                              gradient: LinearGradient(
                                  stops: [0.1, 0.9],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [C.blue600, C.orange600]))
                          : null,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  C.textColorTertiary.withOpacity(1),
                            ),
                            if (index == 0)
                              Positioned(
                                  bottom: 0,
                                  child: Image.asset(
                                      Assets.images.bestMatch.path,
                                      width: 60))
                          ],
                        ),
                        Gap(8),
                        Text("Name"),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                                5,
                                (index) => Icon(Icons.star,
                                    size: 8, color: Colors.orange)),
                            Gap(4),
                            Text("4.5", style: context.textTheme.noteStyle),
                          ],
                        ),
                        Gap(8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: C.tertiaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text("P400",
                              style: context.textTheme.noteStyle.copyWith(
                                  color: C.blue500,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Gap(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: C.hintColor,
                              size: 15,
                            ),
                            Text("Location",
                                style: context.textTheme.noteStyle),
                          ],
                        ),
                        Text("0.5 km away", style: context.textTheme.noteStyle),
                        Gap(12),
                        Text("View Profile",
                            style: context.textTheme.bodySmall?.copyWith(
                                color: C.blue500, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _reviewProfile(WorkerModel worker,
      {required BuildContext context}) async {
    await showFlexibleBottomSheet(
        bottomSheetColor: Colors.white,
        maxHeight: .9,
        minHeight: .5,
        initHeight: .9,
        context: context,
        builder: (context, scrollController, bottomSheetOffset) {
          var height = MediaQuery.of(context).size.height * 0.9;
          //user profile
          return ProfileBottomSheet(
              height: height,
              worker: worker,
              scrollController: scrollController);
        });
  }
}

class _ChipDropdownFilter extends StatefulWidget {
  const _ChipDropdownFilter({
    required this.label,
    required this.icon,
    required this.options,
  });

  final String label;
  final Widget icon;
  final List<String> options;

  @override
  State<_ChipDropdownFilter> createState() => _ChipDropdownFilterState();
}

class _ChipDropdownFilterState extends State<_ChipDropdownFilter> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: C.fieldColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: widget.icon,
          style: context.textTheme.noteStyle,
          isDense: true,
          value: _selectedOption,
          hint: Text(widget.label, style: context.textTheme.noteStyle),
          items: widget.options
              .map((option) => DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedOption = value;
            });
          },
        ),
      ),
    );
  }
}
