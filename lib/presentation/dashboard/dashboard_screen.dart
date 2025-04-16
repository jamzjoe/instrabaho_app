import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:instrabaho_app/constant/data/category_mock_data.dart';
import 'package:instrabaho_app/constant/data/feautured_mock_data.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_text.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/work_status_bloc.dart';
import 'package:instrabaho_app/presentation/dashboard/bloc/work_status_event.dart';
import 'package:instrabaho_app/presentation/dashboard/widgets/upload_id.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appBarSize = AppBar().preferredSize.height;
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(appBarSize),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Hello, Juan!",
                                          style: context.textTheme.welcomeText),
                                      const Gap(10),
                                      Image.asset(Assets.images.wavingHand.path,
                                          width: 20),
                                    ],
                                  ),
                                  Text("Need a skilled worker today?"),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.notifications_outlined,
                                    size: 24, color: Colors.black),
                              ),
                              Positioned(
                                right: -5,
                                top: -10,
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    UploadID(),
                    Gap(20),
                    SizedBox(
                      height: 200,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  GoRouter.of(context)
                                      .pushNamed(RouterNames.jobStatus);
                                  BlocProvider.of<WorkStatusBloc>(context)
                                      .add(StartWorkStatus());
                                },
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Container(
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.only(right: 8),
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: GradientBoxBorder(
                                            width: .5,
                                            gradient: LinearGradient(colors: [
                                              Colors.green,
                                              C.blue600,
                                            ])),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                      ),
                                      child: IntrinsicHeight(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Gap(0),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(24.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText.subTitle(context,
                                                      'Worker is on the way to your location',
                                                      color: Colors.green),
                                                  Gap(8),
                                                  CustomText.title(context,
                                                      'Bathroom Deep Cleaning'),
                                                  Gap(8),
                                                  Row(
                                                    children: [
                                                      CustomText.notesBold(
                                                          context,
                                                          "Assigned to:"),
                                                      CustomText.notes(context,
                                                          '2 hours ago'),
                                                    ],
                                                  ),
                                                  Gap(8),
                                                  Row(
                                                    children: [
                                                      CustomText.notesBold(
                                                          context, "Location:"),
                                                      CustomText.notes(context,
                                                          'BGC Taguig'),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                              ),
                                              child: Row(
                                                children: [
                                                  CustomText.buttonText(context,
                                                      "View Worker's Progress",
                                                      color: Colors.white),
                                                  Spacer(),
                                                  SvgPicture.asset(
                                                      Assets.icon.arrowRight)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () => GoRouter.of(context)
                                    .pushNamed(RouterNames.jobPost),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Container(
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.only(right: 8),
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: GradientBoxBorder(
                                            width: .5,
                                            gradient: LinearGradient(colors: [
                                              C.orange600,
                                              C.blue600,
                                            ])),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                      ),
                                      child: IntrinsicHeight(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Gap(0),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(24.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(Assets
                                                      .images.needHelp.path),
                                                  Gap(8),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomText.title(
                                                          context,
                                                          'Need more help?',
                                                        ),
                                                        CustomText.notes(
                                                            context,
                                                            'You can still post a job while your current job is on progress'),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                GoRouter.of(context).pushNamed(
                                                    RouterNames.jobPost);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: C.blue600,
                                                ),
                                                child: Row(
                                                  children: [
                                                    CustomText.buttonText(
                                                        context, "Post a Job",
                                                        color: Colors.white),
                                                    Spacer(),
                                                    SvgPicture.asset(
                                                        Assets.icon.arrowRight)
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Gap(20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed(RouterNames.jobStatus);
                        },
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Container(
                              clipBehavior: Clip.antiAlias,
                              width: MediaQuery.of(context).size.width - 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: GradientBoxBorder(
                                    width: .5,
                                    gradient: LinearGradient(colors: [
                                      Colors.lightBlue,
                                      C.blue600,
                                    ])),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child: IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            Assets.images.paintBrush.path,
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(24.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText.subTitle(context,
                                                      'Need a Helping Hand?'),
                                                  Gap(8),
                                                  CustomText.notes(
                                                    context,
                                                    'You haven’t posted any jobs yet. Find skilled workers for your home repairs, maintenance, and more.',
                                                    fontSize: 13,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                      ),
                                      child: Row(
                                        children: [
                                          CustomText.buttonText(
                                              context, "Post a Job",
                                              color: Colors.white),
                                          Spacer(),
                                          SvgPicture.asset(
                                              Assets.icon.arrowRight)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Gap(60)
                  ],
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.images.bg2.path),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover)),
              ),
            ],
          ),
          Transform.translate(
            offset: Offset(0, -30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: .5, color: C.hintColor),
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      Assets.icon.wallet.path,
                                      width: 25,
                                    ),
                                    Gap(8),
                                    Text("P500.00",
                                        style: context.textTheme.moneyText),
                                  ],
                                ),
                                Gap(8),
                                Text("Balance"),
                              ],
                            ),
                          ),
                        ),
                        Gap(16),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: .5, color: C.hintColor),
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      Assets.icon.reward.path,
                                      width: 25,
                                    ),
                                    Gap(8),
                                    Text("20",
                                        style: context.textTheme.moneyText),
                                  ],
                                ),
                                Gap(8),
                                Text("Points"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText.title(context, 'Top Categories'),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(categories.length + 1, (index) {
                          if (index == categories.length) {
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                return Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(8),
                                        width: 100,
                                        height: 100,
                                        child: Center(
                                          child: SvgPicture.asset(
                                              Assets.categories.allCategory,
                                              width: 32,
                                              height: 32),
                                        ),
                                        decoration: BoxDecoration(
                                          color: C.blue600.withAlpha(50),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      Gap(8),
                                      Text("All",
                                          style: context.textTheme.bodyStyle),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          final category = categories[index];
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage(category.imageUrl),
                                            fit: BoxFit.cover),
                                        color: C.hintColor.withAlpha(50),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    Gap(8),
                                    Text("${category.name}",
                                        style: context.textTheme.bodyStyle),
                                  ],
                                ),
                              );
                            },
                          );
                        })
                      ],
                    ),
                  ),
                  Gap(10),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(featuredData.length, (i) {
                          final featured = featuredData[i];
                          //gap 16 left ecxcept first index
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                margin: EdgeInsets.only(left: i == 0 ? 0 : 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText.title(
                                        context, '${featured.name}'),
                                    Gap(8),
                                    Image.asset(featured.imageUrl)
                                  ],
                                ),
                              );
                            },
                          );
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
