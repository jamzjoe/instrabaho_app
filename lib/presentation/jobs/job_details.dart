import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
            padding: EdgeInsets.all(10),
            child: Row(children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: C.blue600,
                        foregroundColor: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Apply job", style: TextStyle(fontSize: 20)),
                    )),
              )
            ])),
        appBar: AppBar(
          title: const Text('Job Details'),
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark_border, color: C.hintColor),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Quezon City", style: context.textTheme.subTitle),
                      Text("Plumbing Services",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Arial",
                              fontSize: 22,
                              color: Color(0xff303030))),
                    ],
                  ),
                  Spacer(),
                  //hear cirlce icon
                  Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(color: const Color(0xFFD2CFE8))),
                      child: Icon(Ionicons.heart, color: C.orange600, size: 30))
                ],
              ),
              Text("Posted 1 hour ago", style: context.textTheme.noteStyle),
              const Gap(10),
              Row(
                children: [
                  Text('Applying in queue:',
                      style: context.textTheme.noteStyle),
                  const Gap(5),
                  Text('3',
                      style: context.textTheme.subTitle
                          .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  Text('Available Instrabaho Points:',
                      style: context.textTheme.noteStyle),
                  const Gap(5),
                  Text('80 Points',
                      style: context.textTheme.subTitle
                          .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Gap(10),
              Divider(color: Colors.grey[300]),
              Gap(10),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Job Details",
                            style: context.textTheme.subTitle
                                .copyWith(fontWeight: FontWeight.bold)),
                        const Gap(10),
                        Text(
                            "We are looking for a skilled plumber to fix our sink. The job requires someone with experience in plumbing repairs, including fixing leaks, unclogging drains, and ensuring that all plumbing systems are functioning properly. The ideal candidate should have a strong attention to detail, be able to work efficiently, and have excellent problem-solving skills. Additionally, the plumber should be able to provide a high level of customer service and communicate effectively with clients.",
                            style: context.textTheme.bodyStyle),
                      ])),
            ])));
  }
}
