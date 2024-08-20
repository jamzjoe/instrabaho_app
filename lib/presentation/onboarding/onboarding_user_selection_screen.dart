import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:ionicons/ionicons.dart';

class OnboardingUserSelectionScreen extends StatelessWidget {
  const OnboardingUserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Assets.images.instrabahoLogo.image(),
                const Gap(10),
                const Text("Job well done!", style: FontStyles.caption),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Continue as", style: FontStyles.header),
                    const Gap(10),
                    const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ",
                        style: FontStyles.caption),
                    const Gap(20),
                    Column(
                      children: [
                        _UserContainer(
                            icon: const Icon(Ionicons.construct,
                                size: 30, color: Colors.grey),
                            title: "JOB SEEKER",
                            subtitle: "Find a job",
                            onTap: () {
                              context.pushNamed(RouterNames.login,
                                  extra: 'JOB SEEKER');
                            }),
                        const Gap(15),
                        _UserContainer(
                            icon: const Icon(Ionicons.bag,
                                size: 30, color: Colors.grey),
                            title: "COMPANY",
                            subtitle: "Post a job",
                            onTap: () {
                              context.pushNamed(RouterNames.login,
                                  extra: 'COMPANY');
                            }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UserContainer extends StatelessWidget {
  const _UserContainer(
      {required this.title,
      required this.subtitle,
      required this.onTap,
      required this.icon});
  final String title;
  final String subtitle;
  final Function() onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            icon,
            const Gap(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: FontStyles.subheader),
                Text(subtitle, style: FontStyles.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
