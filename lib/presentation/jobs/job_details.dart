import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Job Details'),
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark_border),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("High Speed Software Developer"),
                      Text("Google"),
                    ],
                  ),
                  Spacer(),
                  Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 100,
                  )
                ],
              ),
              const Gap(5),
              Divider(color: Colors.grey[300]),
              const Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(radius: 40),
                      Gap(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Salary", style: FontStyles.subheader),
                          Text("₱ 100,000 - 150,000"),
                        ],
                      )
                    ],
                  ),
                  Gap(10),
                  Row(
                    children: [
                      CircleAvatar(radius: 40),
                      Gap(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Salary", style: FontStyles.subheader),
                          Text("₱ 100,000 - 150,000"),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
