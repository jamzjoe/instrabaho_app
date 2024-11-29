import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/mock_data/skills.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          const _ProfileHeader(),
          const Gap(60),
          const _ProfileInfos(),
          const Gap(15),
          const _ProfileActions(),
          const Gap(15),
          const _Resume(),
          const Gap(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Skill", style: FontStyles.subheader),
                GridView.count(
                  padding: EdgeInsets.zero,
                  childAspectRatio: .8,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ...skills.map((e) => ProgressPercentage(skill: e))
                  ],
                )
              ],
            ),
          )
        ]))
      ],
    );
  }
}

class ProgressPercentage extends StatelessWidget {
  const ProgressPercentage({super.key, required this.skill});
  final Skill skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(40)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              //  create circular progress indicator
              Center(
                  child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                    value: skill.percentage,
                    strokeWidth: 5,
                    color: primaryColor),
              )),
              Center(
                child: Text("${(skill.percentage * 100).toStringAsFixed(0)}%",
                    style: FontStyles.caption),
              ),
            ],
          ),
          const Gap(25),
          Text(skill.skillName, style: FontStyles.caption)
        ],
      ),
    );
  }

  double _getRandomValue() {
    final random = Random();
    return random.nextDouble();
  }
}

class _Resume extends StatelessWidget {
  const _Resume();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 25),
      margin: const EdgeInsets.symmetric(horizontal: 32),
      decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Resume",
                style: FontStyles.subheader.copyWith(color: Colors.white),
              ),
              Text("my_resume.pdf",
                  style: FontStyles.tiny.copyWith(color: Colors.white))
            ],
          ),
          const Spacer(),
          const Icon(Ionicons.ellipsis_vertical, color: Colors.white)
        ],
      ),
    );
  }
}

class _ProfileActions extends StatelessWidget {
  const _ProfileActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
            3,
            (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      radius: 30, backgroundColor: Colors.grey[200]),
                ))
      ],
    );
  }
}

class _ProfileInfos extends StatelessWidget {
  const _ProfileInfos();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text("Instrabaho", style: FontStyles.subheader),
          Text("Flutter Dev"),
          Gap(15),
          Text(
              "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu.",
              style: FontStyles.caption,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 180,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: primaryColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text("Account",
                        style:
                            FontStyles.subheader.copyWith(color: Colors.white)),
                    IconButton(
                      icon: const Icon(Ionicons.ellipsis_vertical,
                          color: Colors.white),
                      onPressed: () {
                        showMenu(
                          context: context,
                          position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                          items: [
                            const PopupMenuItem<String>(
                              value: 'logout',
                              child: Text('Logout'),
                            ),
                          ],
                          elevation: 8.0,
                        ).then((value) {
                          if (value == 'logout') {
                            // ignore: use_build_context_synchronously
                            context.goNamed(RouterNames.onboarding);
                          }
                        });
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: -50,
          left: 0,
          right: 0,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.white),
                shape: BoxShape.circle,
                color: primaryColor),
          ),
        )
      ],
    );
  }
}
