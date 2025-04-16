import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_text.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({
    super.key,
  });

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _selectedChipIndex = 0;
  final List<String> _filterChips = [
    'All',
    'Completed',
    'Cancelled',
    'Ongoing'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText.appBar(context, "History"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filterChips.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    backgroundColor: Colors.grey.shade100,
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    selected: _selectedChipIndex == index,
                    label: Text(
                      _filterChips[index],
                      style: context.textTheme.bodyMedium?.copyWith(
                          color: _selectedChipIndex == index
                              ? Colors.white
                              : C.blue600,
                          fontWeight: FontWeight.bold),
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedChipIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildHistoryGroup('Today', [
                  _buildHistoryItem(
                    'Plumbing Repair',
                    'John Doe',
                    '₱500',
                    '10:00 AM',
                    'Completed',
                  ),
                  _buildHistoryItem(
                    'Electrical Installation',
                    'Jane Smith',
                    '₱800',
                    '2:30 PM',
                    'Ongoing',
                  ),
                ]),
                const Gap(20),
                _buildHistoryGroup('Yesterday', [
                  _buildHistoryItem(
                    'Carpentry Work',
                    'Mike Johnson',
                    '₱1200',
                    '9:00 AM',
                    'Cancelled',
                  ),
                  _buildHistoryItem(
                    'House Cleaning',
                    'Sarah Wilson',
                    '₱400',
                    '11:00 AM',
                    'Completed',
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryGroup(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.subTitle),
        const Gap(10),
        ...items,
      ],
    );
  }

  Widget _buildHistoryItem(
    String position,
    String name,
    String amount,
    String time,
    String status,
  ) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'ongoing':
        statusColor = Colors.orange;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        // Mark as read when tapped
        // Todo
        // Mark as read
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: C.blue600.withAlpha(30),
              ),
              child: Image(image: AssetImage(Assets.icon.launcherIcon.path)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //status
                  Text(status,
                      style: context.textTheme.noteStyle.copyWith(
                          color: statusColor, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        position,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: C.textColor,
                        ),
                      ),
                      const Spacer(),
                      //date and time
                      Text(
                        amount,
                        style: TextStyle(
                          fontSize: 12,
                          color: C.textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$name · $time",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
        Icon(icon, color: C.blue700),
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
              color: C.orange600.withOpacity(0.08),
              borderRadius: BorderRadius.circular(90),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                //history
                Icon(Icons.history, color: C.orange600),
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
                        color: C.orange600.withOpacity(0.2),
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
