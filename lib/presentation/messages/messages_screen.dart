import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/domain/data/worker_model.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Add getters for unread counts
  int get _unreadNotificationsCount => _notifications
      .where((notification) => notification['isRead'] == false)
      .length;

  int get _unreadMessagesCount =>
      _messages.where((message) => message['unread'] == true).length;

  // Sample notifications data with dates
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'New Job Offer',
      'message': 'You have received a new job offer for Web Development',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': false,
      'id': '1', // Add unique IDs to notifications
    },
    {
      'title': 'Application Accepted',
      'message':
          'Your application for Graphic Design position has been accepted',
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'isRead': false,
      'id': '2',
    },
    {
      'title': 'Payment Received',
      'message': 'Payment of \$500 has been credited to your account',
      'time': DateTime.now().subtract(const Duration(days: 2)),
      'isRead': true,
      'id': '3',
    },
  ];

  // Sample messages data with unique IDs
  final List<Map<String, dynamic>> _messages = [
    {
      'id': 'm1',
      'name': 'John Smith',
      'lastMessage': 'Hi, I\'m interested in your services',
      'time': DateTime.now().subtract(const Duration(minutes: 30)),
      'unread': true,
      'worker': WorkerModel(
        name: 'John Smith',
        position: 'Web Developer',
        rating: 4.5,
      ),
      'unreadCount': 3, // Add count of unread messages in conversation
    },
    {
      'id': 'm2',
      'name': 'Sarah Johnson',
      'lastMessage': 'When can you start the project?',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'unread': true,
      'worker': WorkerModel(
        name: 'Sarah Johnson',
        position: 'Project Manager',
        rating: 4.8,
      ),
      'unreadCount': 1,
    },
    {
      'id': 'm3',
      'name': 'Mike Wilson',
      'lastMessage': 'Thanks for the great work!',
      'time': DateTime.now().subtract(const Duration(days: 2)),
      'unread': false,
      'worker': WorkerModel(
        name: 'Mike Wilson',
        position: 'Client',
        rating: 4.9,
      ),
      'unreadCount': 0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Add method to mark notification as read
  void _markAsRead(String notificationId) {
    setState(() {
      final index = _notifications.indexWhere((n) => n['id'] == notificationId);
      if (index != -1) {
        _notifications[index]['isRead'] = true;
      }
    });
  }

  // Add method to mark message as read
  void _markMessageAsRead(String messageId) {
    setState(() {
      final index = _messages.indexWhere((m) => m['id'] == messageId);
      if (index != -1) {
        _messages[index]['unread'] = false;
        _messages[index]['unreadCount'] = 0;
      }
    });
  }

  Map<String, List<Map<String, dynamic>>> _groupNotificationsByDate() {
    final Map<String, List<Map<String, dynamic>>> groupedNotifications = {};

    for (var notification in _notifications) {
      final DateTime notificationTime = notification['time'] is String
          ? DateTime.parse(notification['time'])
          : notification['time'];
      final DateTime now = DateTime.now();
      final DateTime today = DateTime(now.year, now.month, now.day);
      final DateTime yesterday = today.subtract(const Duration(days: 1));

      String groupKey;
      if (notificationTime.isAfter(today)) {
        groupKey = 'Today';
      } else if (notificationTime.isAfter(yesterday)) {
        groupKey = 'Yesterday';
      } else {
        groupKey = 'Earlier';
      }

      if (!groupedNotifications.containsKey(groupKey)) {
        groupedNotifications[groupKey] = [];
      }
      groupedNotifications[groupKey]!.add(notification);
    }

    return groupedNotifications;
  }

  String _formatTime(DateTime time) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(time);

    if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }

  String _formatMessageTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(time.year, time.month, time.day);

    if (messageDate == today) {
      final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
      final amPm = time.hour >= 12 ? 'PM' : 'AM';
      return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $amPm';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return GestureDetector(
      onTap: () {
        // Mark as read when tapped
        // Todo
        // Mark as read
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification['isRead'] ? Colors.white : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification['isRead']
                ? Colors.transparent
                : C.blue700.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: C.blue700.withAlpha(30),
                  ),
                  child:
                      Image(image: AssetImage(Assets.icon.launcherIcon.path)),
                ),
                if (!notification['isRead'])
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: C.blue700,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        notification['title'] ?? 'No Title',
                        style: TextStyle(
                          fontWeight: notification['isRead']
                              ? FontWeight.normal
                              : FontWeight.bold,
                          color: notification['isRead']
                              ? Colors.black87
                              : C.blue700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _formatTime(notification['time']),
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              notification['isRead'] ? Colors.grey : C.blue700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification['message'] ?? 'No Message',
                    style: TextStyle(
                      color:
                          notification['isRead'] ? Colors.grey : Colors.black87,
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

  Widget _buildMessageItem(Map<String, dynamic> message) {
    final String name = message['name']?.toString() ?? 'Unknown';
    final String lastMessage =
        message['lastMessage']?.toString() ?? 'No Message';
    final DateTime time = message['time'] is DateTime
        ? message['time']
        : DateTime.tryParse(message['time'].toString()) ?? DateTime.now();
    final bool unread = message['unread'] ?? false;
    final int unreadCount = message['unreadCount'] ?? 0;

    return InkWell(
      onTap: () {
        //Todo
        // Handle navigation to message conversation
        context.pushNamed(RouterNames.messageConversation,
            extra: WorkerModel(name: name, position: 'Plumber', rating: 5));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: unread ? C.blue700 : Colors.grey[300],
                  child: Text(
                    name.isNotEmpty ? name[0] : '?',
                    style: TextStyle(
                      color: unread ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                if (unread)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        color: C.blue700,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: unread ? FontWeight.bold : FontWeight.normal,
                      color: unread ? C.blue700 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: unread ? Colors.black87 : Colors.grey,
                      fontWeight: unread ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatMessageTime(time),
                  style: TextStyle(
                    fontSize: 12,
                    color: unread ? C.blue700 : Colors.grey,
                    fontWeight: unread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (unreadCount > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: C.blue700,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Inbox'),
        bottom: TabBar(
          labelStyle: context.textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: C.blue700,
          ),
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          dividerColor: Colors.grey.shade300,
          indicatorWeight: .5,
          controller: _tabController,
          indicatorColor: C.blue700,
          tabs: [
            Tab(
              child: Row(
                children: [
                  const Text('Messages'),
                  if (_unreadMessagesCount > 0)
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: C.blue700,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _unreadMessagesCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  const Text('Notifications'),
                  if (_unreadNotificationsCount > 0)
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: C.blue700,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _unreadNotificationsCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Messages Tab
          ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) =>
                _buildMessageItem(_messages[index]),
          ),
          // Notifications Tab
          ListView.builder(
            itemCount: _groupNotificationsByDate().length,
            itemBuilder: (context, index) {
              final group =
                  _groupNotificationsByDate().entries.elementAt(index);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      group.key,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: C.textColor,
                      ),
                    ),
                  ),
                  ...group.value.map(
                      (notification) => _buildNotificationItem(notification)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
