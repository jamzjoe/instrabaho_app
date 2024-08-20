import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:ionicons/ionicons.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
        SliverList(
            delegate: SliverChildListDelegate([
          const SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _JobCount(),
                Gap(20),
                _Categories(),
                Gap(20),
                _RecommendedJobs(),
                Gap(20),
                _RecentJobs()
              ],
            ),
          ),
        ]))
      ],
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
                    (index) => Container(
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Categories", style: FontStyles.subheader),
          const Gap(5),
          GridView.count(
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
                );
              })
            ],
          )
        ],
      ),
    );
  }
}

class _JobCount extends StatelessWidget {
  const _JobCount();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _JobCountInfo(
              iconBackDrop: Icon(
                Ionicons.checkmark_circle_outline,
                size: 120,
              ),
              label: 'Jobs Applied',
              countValue: 40,
              backgroundColor: primaryColor),
          Gap(10),
          _JobCountInfo(
              iconBackDrop: Icon(
                CupertinoIcons.question_circle,
                size: 120,
              ),
              label: 'Interviews',
              countValue: 2,
              backgroundColor: secondaryColor),
        ],
      ),
    );
  }
}

class _JobCountInfo extends StatelessWidget {
  const _JobCountInfo(
      {required this.countValue,
      required this.label,
      required this.backgroundColor,
      required this.iconBackDrop});

  final String label;
  final int countValue;
  final Color backgroundColor;
  final Widget iconBackDrop;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Container(
              height: 130,
            ),
            Positioned(
              bottom: -30,
              right: -20,
              child: ColorFiltered(
                  colorFilter:
                      ColorFilter.mode(backgroundColor, BlendMode.lighten),
                  child: iconBackDrop),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$countValue',
                      style: FontStyles.header
                          .copyWith(color: Colors.white, fontSize: 36)),
                  Text(label,
                      style: FontStyles.caption.copyWith(color: Colors.white))
                ],
              ),
            ),
          ],
        ),
      ),
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
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
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
            const CircleAvatar(radius: 30)
          ],
        ),
      ),
    );
  }
}

class DashboardSearchBar extends StatelessWidget {
  const DashboardSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ]),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search job here...",
          prefixIcon: const Icon(Icons.search),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
