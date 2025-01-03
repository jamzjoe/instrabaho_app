import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/presentation/common/widgets/instrabaho_textfield.dart';

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
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text('Messages', style: context.textTheme.titleLarge)),
        SliverList(
            delegate: SliverChildListDelegate([
          MessagesSearchBar(),
          ListView(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [...List.generate(20, (index) => const Message())],
          )
        ]))
      ],
    ));

    // );
  }
}

class Message extends StatelessWidget {
  const Message({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => context.pushNamed(RouterNames.messageConversation),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(radius: 30, backgroundColor: Colors.grey),
            const Gap(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('John Doe', style: FontStyles.subheader),
                const Text('Hello there!', style: FontStyles.noteStyle),
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('2 mins ago',
                        style: FontStyles.tiny.copyWith(color: hintColor)),
                    const Gap(16),
                    Row(
                      children: [
                        Icon(Icons.check,
                            size: 10, color: primaryColor.withOpacity(0.5)),
                        const Gap(5),
                        Text('Read',
                            style: FontStyles.tiny.copyWith(color: hintColor))
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MessagesSearchBar extends StatelessWidget {
  const MessagesSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return InstrabahoTextField(hintText: 'Search for messages');
  }
}
