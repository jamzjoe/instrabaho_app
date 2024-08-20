import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';

class InboxItem {
  final String profile;
  final bool isOnline;
  final bool isRead;
  final String recentMessage;
  final String name;

  InboxItem({
    required this.profile,
    required this.isOnline,
    required this.isRead,
    required this.recentMessage,
    required this.name,
  });
}

class Messages extends StatelessWidget {
  Messages({
    super.key,
  });

  final List<InboxItem> inboxItems = [
    InboxItem(
      profile: 'assets/profile1.png',
      isOnline: true,
      isRead: false,
      recentMessage: 'Hello there!',
      name: 'John Doe',
    ),
    InboxItem(
      profile: 'assets/profile2.png',
      isOnline: false,
      isRead: true,
      recentMessage: 'How are you?',
      name: 'Jane Smith',
    ),
    // Add more inbox items here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FittedBox(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(60))),
            child: Row(
              children: [
                const Icon(
                  Ionicons.add,
                  color: Colors.white,
                ),
                const Gap(5),
                Text("New Chat",
                    style: FontStyles.caption.copyWith(color: Colors.white))
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                floating: true,
                snap: true,
                toolbarHeight: 145,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text("Messages", style: FontStyles.subheader),
                      Gap(15),
                      MessagesSearchBar()
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ...List.generate(
                        20,
                        (index) => Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                      radius: 30, backgroundColor: Colors.grey),
                                  const Gap(15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('John Doe',
                                          style: FontStyles.subheader),
                                      const Text('Hello there!',
                                          style: FontStyles.caption),
                                      const Gap(5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('2 mins ago',
                                              style: FontStyles.tiny
                                                  .copyWith(color: hintColor)),
                                          const Gap(16),
                                          Row(
                                            children: [
                                              Icon(Icons.check,
                                                  size: 10,
                                                  color: primaryColor
                                                      .withOpacity(0.5)),
                                              const Gap(5),
                                              Text('Read',
                                                  style: FontStyles.tiny
                                                      .copyWith(
                                                          color: hintColor))
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ))
                  ],
                )
              ]))
            ],
          ),
        ));

    // );
  }
}

class MessagesSearchBar extends StatelessWidget {
  const MessagesSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(99.0), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: TextField(
        decoration: InputDecoration(
          focusColor: Colors.white,
          fillColor: Colors.white,
          filled: true,
          hintText: 'Search message..',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(99.0),
          ),
        ),
      ),
    );
  }
}
