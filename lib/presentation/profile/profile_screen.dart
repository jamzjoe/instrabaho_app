import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarSize = AppBar().preferredSize.height;
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(appBarSize),
          // Text("Profile Study v1"),
          // Column(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: Row(
          //         children: [
          //           CircleAvatar(),
          //           Gap(10),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text('Profile Name'),
          //               Text('Member Since: 2021',
          //                   style: context.textTheme.noteStyle
          //                       .copyWith(fontSize: 12)),
          //             ],
          //           ),
          //           Spacer(),
          //           ElevatedButton(onPressed: () {}, child: Text("See Profile"))
          //         ],
          //       ),
          //     ),
          //     Gap(20),
          //     Container(
          //       padding: const EdgeInsets.all(16),
          //       decoration: BoxDecoration(color: hintColor.withOpacity(0.05)),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Column(
          //             children: [
          //               Text('89',
          //                   style: context.textTheme.countStyle
          //                       .copyWith(height: .8)),
          //               Text('Jobs Completed',
          //                   style: context.textTheme.noteStyle),
          //             ],
          //           ),
          //           Gap(30),
          //           Column(
          //             children: [
          //               Text('10',
          //                   style: context.textTheme.countStyle
          //                       .copyWith(height: .8)),
          //               Text('Badges', style: context.textTheme.noteStyle),
          //             ],
          //           ),
          //           Gap(30),
          //           Column(
          //             children: [
          //               Text('678',
          //                   style: context.textTheme.countStyle
          //                       .copyWith(height: .8)),
          //               Text('Total Points',
          //                   style: context.textTheme.noteStyle),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Gap(20),
          //     //gradient linear progress bar
          //     Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Row(
          //                 children: [
          //                   //construciton icon
          //                   Icon(Icons.construction, color: primaryColor),
          //                   Gap(5),
          //                   Text('Master Plumber',
          //                       style: context.textTheme.noteStyle),
          //                 ],
          //               ),
          //               Text("2/3 applications completed",
          //                   style: context.textTheme.noteStyle),
          //             ],
          //           ),
          //           Gap(3),
          //           Container(
          //             height: 10,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(10),
          //               gradient: LinearGradient(
          //                 colors: [primaryColor, secondaryColor],
          //                 begin: Alignment.centerLeft,
          //                 end: Alignment.centerRight,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // Gap(20),
          // Text("Profile Study v2"),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(),
                Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Profile Name'),
                      Gap(5),

                      //rank
                      Row(
                        children: [
                          Image(
                              image: AssetImage(Assets.icon.crown.path),
                              width: 20),
                          Gap(5),
                          Text("MASTER PLUMBER",
                              style: context.textTheme.rankStyle),
                        ],
                      ),
                      Gap(5),
                      //linear progress bar
                      Container(
                        // width: MediaQuery.of(context).size.width * 0.85,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              stops: [
                                0.2,
                                0.8
                              ],
                              colors: [
                                primaryColor,
                                hintColor.withOpacity(0.3)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                        ),
                      ),
                      Gap(5),
                      Row(
                        children: [
                          Text("LEVEL 2",
                              style: context.textTheme.rankStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: demphasize)),
                          Spacer(),
                          Text("12,034 points to go",
                              style: context.textTheme.noteStyle),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap(20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: hintColor.withOpacity(0.05)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('89',
                        style:
                            context.textTheme.countStyle.copyWith(height: .8)),
                    Text('Jobs Completed', style: context.textTheme.noteStyle),
                  ],
                ),
                Gap(30),
                Column(
                  children: [
                    Text('10',
                        style:
                            context.textTheme.countStyle.copyWith(height: .8)),
                    Text('Badges', style: context.textTheme.noteStyle),
                  ],
                ),
                Gap(30),
                Column(
                  children: [
                    Text('678',
                        style:
                            context.textTheme.countStyle.copyWith(height: .8)),
                    Text('Total Points', style: context.textTheme.noteStyle),
                  ],
                ),
              ],
            ),
          ),
          //settings items
          Gap(20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: fieldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: hintColor),
                      Gap(10),
                      Text("Edit Profile", style: context.textTheme.noteStyle),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size: 15),
                    ],
                  ),
                ),
                Gap(10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: fieldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.notifications, color: hintColor),
                      Gap(10),
                      Text("Notifications", style: context.textTheme.noteStyle),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size: 15),
                    ],
                  ),
                ),
                Gap(10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: fieldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.lock, color: hintColor),
                      Gap(10),
                      Text("Change Password",
                          style: context.textTheme.noteStyle),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size: 15),
                    ],
                  ),
                ),
                Gap(10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: fieldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.help, color: hintColor),
                      Gap(10),
                      Text("Help & Support",
                          style: context.textTheme.noteStyle),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size: 15),
                    ],
                  ),
                ),
                Gap(10),
                GestureDetector(
                  onTap: () {
                    context.goNamed(RouterNames.onboarding);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: fieldColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: hintColor),
                        Gap(10),
                        Text("Logout", style: context.textTheme.noteStyle),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
