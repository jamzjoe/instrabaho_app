import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appBarSize = AppBar().preferredSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Gap(appBarSize),
              const _InterviewHeader(),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:
                    Text('Recent Activity', style: context.textTheme.subTitle),
              ),
              ...List.generate(20, (index) {
                return RecentJobs();
              })
            ]),
          ),
        ],
      ),
    );
  }
}

class RecentJobs extends StatelessWidget {
  const RecentJobs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        context.goNamed(RouterNames.activityDetails);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(),
            Gap(10),
            Expanded(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Repair Mang Domeng faucet in the kitchen',
                                  style: context.textTheme.bodyLarge,
                                ),
                                Gap(5),
                                Text('9 Dec 2021, 10:00 AM',
                                    style: context.textTheme.noteStyle
                                        .copyWith(fontSize: 12)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Php 500",
                                    style: context.textTheme.bodyLarge),
                                //points eg. +25 points
                                Text("+25 points",
                                    style: context.textTheme.noteStyle),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomButton(
                        icon: Icons.chevron_right,
                        text: "Rate",
                        onPressed: () {},
                      ),
                      Gap(10),
                      CustomButton(
                        icon: Icons.chevron_right,
                        text: "Rebook",
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});

  final IconData icon;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: context.textTheme.noteStyle),
        Gap(5),
        Icon(icon, color: secondaryColor),
      ],
    );
  }
}

class _InterviewHeader extends StatelessWidget {
  const _InterviewHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Text('Activity', style: context.textTheme.titleLarge),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(90),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                //history
                Icon(Icons.history, color: primaryColor),
                const Gap(10),
                Text('History', style: context.textTheme.noteStyle),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final Widget body;

  const CustomExpansionTile(
      {super.key, required this.title, required this.body});

  @override
  State<StatefulWidget> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Initation to Interview (3)",
                        style: FontStyles.subheader),
                    const Spacer(),
                    Icon(_isExpanded ? Icons.expand_less : Icons.expand_more)
                  ],
                ),
                const Gap(10),
                DecoratedBox(
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Row(children: [
                        Icon(Icons.handshake),
                        Gap(10),
                        Flexible(
                          child: Text(
                              "Workers who apply to a job when invited, are hired 5x more often."),
                        )
                      ]),
                    )),
                GestureDetector(
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    duration: const Duration(milliseconds: 200),
                    height: _isExpanded ? null : 0,
                    child: Visibility(
                      visible: _isExpanded,
                      child: widget.body,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
