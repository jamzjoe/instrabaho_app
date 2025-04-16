import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_button.dart';

class ActivityDetailsScreen extends StatelessWidget {
  const ActivityDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.fieldColor,
      bottomSheet: Container(
          padding: EdgeInsets.all(16),
          height: 90,
          child: InstrabahoButton(onTap: () {}, label: "Contact Instrabaho")),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            pinned: true,
            title: Text('Dec 3, 2024 at 3:00 PM',
                style: context.textTheme.appBarFont),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Booking ID"),
                        Text("#123456", style: context.textTheme.bodyStyle),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        CircleAvatar(),
                        Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("John Doe - Quezon City",
                                style: context.textTheme.body),
                            Text("Job Done - GF-1234",
                                style: context.textTheme.noteStyle),
                          ],
                        )
                      ],
                    ),
                  ),
                  Gap(10),
                  const JobDetails(),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class JobDetails extends StatelessWidget {
  const JobDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Job Title"),
                Text("Plumbing", style: context.textTheme.bodyStyle),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Job Description"),
                Text("Fixing kitchen sink", style: context.textTheme.bodyStyle),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date"),
                Text("Dec 3, 2024", style: context.textTheme.bodyStyle),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Time"),
                Text("3:00 PM", style: context.textTheme.bodyStyle),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Location"),
                Text("Quezon City", style: context.textTheme.bodyStyle),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Status"),
                Text("Completed", style: context.textTheme.bodyStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
