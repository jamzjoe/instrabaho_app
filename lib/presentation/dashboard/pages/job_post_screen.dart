import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instrabaho_app/constant/data/listings.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/app/app_bloc.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_dropdown_textfield.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/job_post_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class JobPostScreen extends StatefulWidget {
  const JobPostScreen({super.key});

  @override
  State<JobPostScreen> createState() => _JobPostScreenState();
}

late PageController _pageController;

class _JobPostScreenState extends State<JobPostScreen> {
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.addListener(() {
        context
            .read<JobPostBloc>()
            .add(JobPostChangeScreenIndex(_pageController.page?.toInt() ?? 0));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<JobPostBloc, JobPostState>(
          builder: (context, state) {
            bool isUserTester = context.select<AppBloc, bool>((appBloc) =>
                appBloc.state.user?.email.contains('@t.com') ?? false);
            Function()? onTap;
            final currentPage =
                _pageController.hasClients ? _pageController.page?.toInt() : 0;
            switch (currentPage) {
              case 0:
                onTap = (state.jobPosition.isNotEmpty &&
                        state.jobDescription.isNotEmpty &&
                        state.jobCategory.isNotEmpty)
                    ? () {
                        _nextPage(context, index: 0);
                      }
                    : null;
                break;
              case 1:
                onTap = state.jobPhotos.isNotEmpty || isUserTester
                    ? () {
                        _nextPage(context, index: 1);
                      }
                    : null;
                break;
              case 2:
                onTap = state.jobAddress.isNotEmpty
                    ? () {
                        _nextPage(context, index: 2);
                      }
                    : null;
                break;
              case 3:
                onTap = state.budgetAmount > 0
                    ? () {
                        _nextPage(context, index: 3);
                      }
                    : null;
                break;
              case 4:
                onTap = state.jobSchedule == JobSchedule.now
                    ? () {
                        _nextPage(context, index: 4);
                      }
                    : null;
                break;
              default:
                onTap = null;
                break;
            }
            final isLastPage = state.pageIndex == 5;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(20),
                  child: InstrabahoButton(
                    label: isLastPage ? 'Done' : 'Continue',
                    onTap: isLastPage
                        ? () {
                            context.pushNamed(
                                RouterNames.jobPostConfirmationScreen);
                          }
                        : onTap,
                  ),
                ),
              ],
            );
          },
        ),
        body: BlocBuilder<JobPostBloc, JobPostState>(
          builder: (context, state) {
            final appBarSize = AppBar().preferredSize.height;
            final progressBarPercentage = state.progressBarPercentage;

            return Column(
              children: [
                Gap(appBarSize),

                //create a progress bar here
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 500,
                  padding: EdgeInsets.zero,
                  lineHeight: 8,
                  clipLinearGradient: true,
                  animateFromLastPercent: true,
                  percent: progressBarPercentage,
                  linearGradient: LinearGradient(
                    colors: [C.blue600, C.orange600],
                  ),
                ),

                CustomBackButton(
                  onTap: () {
                    if (_pageController.page == 0) {
                      if (context.canPop()) {
                        context.pop();
                        //reset the job post state
                        context.read<JobPostBloc>().add(JobPostReset());
                      }
                    } else {
                      _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    }
                  },
                ),
                Expanded(
                  child: PageView(
                    dragStartBehavior: DragStartBehavior.start,
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    allowImplicitScrolling: true,
                    children: [
                      //5 pages
                      _FirstPage(),
                      _SecondPage(),
                      _ThirdPage(),
                      _FourthPage(),
                      _FifthWidget(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _nextPage(BuildContext context, {required int index}) {
    _pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    // context.read<JobPostBloc>().add(JobPostChangeScreenIndex(index + 1));
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onTap,
  });
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            onTap?.call();
          },
          icon: SvgPicture.asset(Assets.svg.arrowNarrowLeft),
        ),
      ],
    );
  }
}

class _FifthWidget extends StatelessWidget {
  const _FifthWidget();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<JobPostBloc, JobPostState, JobSchedule>(
      selector: (state) {
        return state.jobSchedule;
      },
      builder: (context, state) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //back button

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context
                            .read<JobPostBloc>()
                            .add(JobPostSetSchedule(JobSchedule.now));
                        Future.delayed(Duration(seconds: 1), () {
                          context
                              .pushNamed(RouterNames.jobPostConfirmationScreen);
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          //make gradient border when jobSchedule is now
                          border: Border.all(
                              color: state == JobSchedule.now
                                  ? C.blue600
                                  : C.hintColor.withOpacity(0.1)),
                          color: C.hintColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text("Book Now",
                            style: context.textTheme.noteStyle15),
                      ),
                    ),
                    Gap(24),
                    GestureDetector(
                      onTap: null
                      // () {
                      //   context
                      //       .read<JobPostBloc>()
                      //       .add(JobPostSetSchedule(JobSchedule.later));
                      //   Future.delayed(Duration(seconds: 1), () {
                      //     context
                      //         .pushNamed(RouterNames.jobPostConfirmationScreen);
                      //   });
                      // }
                      ,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          //make gradient border when jobSchedule is later
                          border: Border.all(
                              color: state == JobSchedule.later
                                  ? C.blue600
                                  : C.hintColor.withOpacity(0.1)),
                          color: C.hintColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text("Schedule for Later",
                            style: context.textTheme.noteStyle15),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _FourthPage extends StatelessWidget {
  const _FourthPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //back button

          Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("What's your budget?",
                  style: context.textTheme.questionText),
              Gap(8),
              Text('Provide a fair offer to attract skilled workers.'),
              Gap(24),
              //amount
              BlocSelector<JobPostBloc, JobPostState, int>(
                selector: (state) {
                  return state.budgetAmount;
                },
                builder: (context, state) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: C.hintColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text('P${NumberFormat('#,##0').format(state)}',
                          style: context.textTheme.amountTextLarge),
                    ),
                  );
                },
              ),
              Gap(24),
              //phone keypad buttons 1-9-0 and delete button x
              Container(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      for (var i = 1; i < 10; i++)
                        InstrabahoButton(
                            textColor: C.textColor,
                            bgColor: Colors.transparent,
                            label: i.toString(),
                            onTap: () {
                              context
                                  .read<JobPostBloc>()
                                  .add(JobPostOnChangeBudget(i));
                            },
                            borderRadius: 0,
                            width: 80,
                            height: 75,
                            fontSize: 24),
                      InstrabahoButton(
                          label: '',
                          width: 80,
                          borderRadius: 0,
                          height: 75,
                          bgColor: Colors.transparent),
                      InstrabahoButton(
                          textColor: C.textColor,
                          bgColor: Colors.transparent,
                          label: '0',
                          onTap: () {
                            context
                                .read<JobPostBloc>()
                                .add(JobPostOnChangeBudget(0));
                          },
                          borderRadius: 0,
                          width: 80,
                          height: 75,
                          fontSize: 24),
                      IconButton(
                        onPressed: () {
                          context
                              .read<JobPostBloc>()
                              .add(JobPostOnDeleteAmountBudget(0));
                        },
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(Assets.svg.deleteIcon,
                              width: 40),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class _ThirdPage extends StatelessWidget {
  const _ThirdPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //back button

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Where is the job located?',
                    style: context.textTheme.questionText),
                Gap(24),
                InstrabahoTextField(
                  hintText: 'Address, city, or barangay.',
                  onChanged: (p0) {
                    context
                        .read<JobPostBloc>()
                        .add(JobPostOnChangeJobAddress(p0));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SecondPage extends StatelessWidget {
  const _SecondPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //back button

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add photos (Optional)',
                    style: context.textTheme.questionText),
                Gap(8),
                Text('Upload images to help workers assess the job.'),
                Gap(24),
                GestureDetector(
                  onTap: () {
                    _pickMultiplePhotos(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: C.hintColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.svg.addIcon),
                        Gap(16),
                        Text('Upload photos', style: context.textTheme.body),
                      ],
                    ),
                  ),
                ),
                Gap(24),
                GestureDetector(
                  onTap: () {
                    _pickPhotoFromCamera(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: C.hintColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.svg.cameraIcon),
                        Gap(16),
                        Text('Take a photo', style: context.textTheme.body),
                      ],
                    ),
                  ),
                ),
                Gap(24),
                //image gallery
                BlocBuilder<JobPostBloc, JobPostState>(
                  builder: (context, state) {
                    return state.jobPhotos.isNotEmpty
                        ? Container(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.jobPhotos.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: FileImage(
                                                  state.jobPhotos[index]),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            context
                                                .read<JobPostBloc>()
                                                .add(JobPostDeletePhoto(index));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : Container();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _pickMultiplePhotos(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      // Handle the selected images
      BlocProvider.of<JobPostBloc>(context)
          .add(JobPostUploadPhotos(images.map((e) => File(e.path)).toList()));
    }
  }

  void _pickPhotoFromCamera(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.camera).then((XFile? image) {
      if (image != null) {
        BlocProvider.of<JobPostBloc>(context)
            .add(JobPostUploadPhotos([File(image.path)]));
      }
    });
  }
}

class _FirstPage extends StatelessWidget {
  const _FirstPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //back button

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('What needs to be done?',
                    style: context.textTheme.questionText),
                Gap(8),
                Text(
                    'Be as detailed as possible to help workers understand your needs.'),
                Gap(24),
                InstrabahoDropdownTextField(
                  hintText: 'Choose the category of service',
                  options: [...searchHints.map((e) => e['job'])],
                  onChanged: (p0) {
                    BlocProvider.of<JobPostBloc>(context)
                        .add(JobPostAddCategory(p0));
                  },
                ),
                Gap(24),
                InstrabahoTextField(
                  hintText: 'Job title',
                  onChanged: (p0) {
                    BlocProvider.of<JobPostBloc>(context)
                        .add(JobPostChangeJobTitle(p0));
                  },
                ),
                Gap(24),
                InstrabahoTextField(
                  hintText: 'Describe the task, e.g., plumbing repair',
                  onChanged: (p0) {
                    BlocProvider.of<JobPostBloc>(context)
                        .add(JobPostOnChangeDescription(p0));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
