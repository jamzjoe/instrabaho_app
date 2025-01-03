import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/dashboard/widgets/dashboard_search_bar.dart';
import 'package:instrabaho_app/presentation/home/cubit/bottom_nav_cubit.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            clipBehavior: Clip.none,
            centerTitle: false,
            toolbarHeight: 130,
            floating: true,
            flexibleSpace: Stack(
              clipBehavior: Clip.none,
              children: [
                DashboardHeader(),
                Positioned(
                    right: 10,
                    left: 10,
                    bottom: -20,
                    child: DashboardSearchBar()),
              ],
            ),
          ),
          //create text field for posting job and list of recent jobs
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const _Categories(),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _RecentJobs extends StatelessWidget {
  const _RecentJobs();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text("Recent Jobs", style: FontStyles.subheader),
              Spacer(),
              Text("View All", style: FontStyles.caption),
            ],
          ),
        ),
        const Gap(10),
        Container(
            color: Colors.white,
            child: Column(
              children: [
                ...List.generate(
                    20,
                    (index) => GestureDetector(
                          onTap: () {
                            context.pushNamed(RouterNames.jobDetails);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const Gap(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Job Title",
                                        style: FontStyles.caption),
                                    const Text('Company Name',
                                        style: FontStyles.caption),
                                    const Gap(5),
                                    Row(
                                      children: [
                                        SvgPicture.asset(Assets.svg.coins),
                                        const Gap(5),
                                        const Text("Php 1,000 - 2,000",
                                            style: FontStyles.caption),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))
              ],
            ))
      ],
    );
  }
}

class _RecommendedJobs extends StatelessWidget {
  const _RecommendedJobs();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("Recommended Jobs", style: FontStyles.subheader),
        ),
        SizedBox(
          height: 125,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    20,
                    (index) => Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(
                              right: 10, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ]),
                          child: Row(
                            children: [
                              const CircleAvatar(),
                              const Gap(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Job Title",
                                      style: FontStyles.caption),
                                  const Text('Company Name',
                                      style: FontStyles.caption),
                                  const Gap(5),
                                  Row(
                                    children: [
                                      SvgPicture.asset(Assets.svg.coins),
                                      const Gap(5),
                                      const Text("Php 1,000 - 2,000",
                                          style: FontStyles.caption),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(10),
          GridView.count(
            padding: EdgeInsets.symmetric(vertical: 15),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 4,
            children: [
              ...List.generate(8, (index) {
                final lastIndex = index == 7;
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: .5, color: Colors.grey.withOpacity(0.4)),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: lastIndex ? Colors.grey[200] : Colors.white),
                  child: Icon(
                    Icons.work_outline_outlined,
                    color: hintColor,
                  ),
                );
              })
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _RowItem(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Balance", style: context.textTheme.hintStyle),
                      Row(
                        children: [
                          Text("Php 1,000.00"),
                          Gap(10),
                          //wallet icon
                          Icon(Icons.account_balance_wallet,
                              color: primaryColor.withOpacity(0.5))
                        ],
                      ),
                    ],
                  ),
                ),
                _RowItem(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Instrabaho Rewards",
                              style: context.textTheme.hintStyle),
                          Gap(5),
                          Text("68"),
                        ],
                      ),
                      Gap(10),
                      //reward icon
                      Icon(Icons.card_giftcard,
                          color: primaryColor.withOpacity(0.5))
                    ],
                  ),
                )
              ],
            ),
          ),
          const Gap(20),
          Text("Discover jobs you may like", style: context.textTheme.subTitle),
          const Gap(10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _RowItem(
                    child: Container(
                  height: 100,
                  width: 300,
                )),
                _RowItem(
                    child: Container(
                  height: 100,
                  width: 300,
                )),
                _RowItem(
                    child: Container(
                  height: 100,
                  width: 300,
                )),
                _RowItem(
                    child: Container(
                  height: 100,
                  width: 300,
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(16),
      child: child,
      decoration: BoxDecoration(
          border: Border.all(width: .5, color: Colors.grey.withOpacity(0.4)),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
    );
  }
}

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(color: secondaryColor),
      padding: const EdgeInsets.all(20.0),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Good morning",
                    style: FontStyles.subheader.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                Text("User",
                    style: FontStyles.caption.copyWith(color: Colors.white)),
              ],
            ),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  GoRouter.of(context).goNamed(RouterNames.profile);
                  BlocProvider.of<BottomNavCubit>(context)
                      .selectTab(BottomNavTab.profile);
                },
                child: const CircleAvatar(
                    radius: 30, backgroundColor: Colors.white))
          ],
        ),
      ),
    );
  }
}
