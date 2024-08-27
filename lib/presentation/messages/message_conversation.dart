import 'package:flutter/material.dart';

class MessagesConversationScreen extends StatefulWidget {
  const MessagesConversationScreen({super.key});
  @override
  _MessagesConversationScreenState createState() =>
      _MessagesConversationScreenState();
}

class _MessagesConversationScreenState
    extends State<MessagesConversationScreen> {
  final List<Message> messages = [
    Message(
        sender: 'Friend',
        chat: 'Hello, how are you?',
        datetime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 13, 6)),
    Message(
        sender: 'User',
        chat: 'I\'m good, thanks! How about you?',
        datetime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 13, 10)),
    Message(
        sender: 'Friend',
        chat: 'I\'m doing well, thanks for asking!',
        datetime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 13, 15))
  ];

  final TextEditingController chatInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {Navigator.pop(context);}
        ),

        title: const Row(
          children: [
            const Icon(Icons.circle),
            SizedBox(width: 8),
            Text('Friend') 
          ]
        )

      ),
      
      body: Column(

        children: [

          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message.sender == 'User';
                
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: isUserMessage ? const Color(0xff3e1693) : const Color(0xfffceed4),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Text(
                          message.chat,
                          style: TextStyle(color: isUserMessage ? Colors.white : Colors.black)
                        )
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatStamp(message.datetime),
                        style: const TextStyle(
                          color: Color(0xff959299), 
                          fontSize: 12
                        )
                      )
                    ]
                  )
                );
              }
            )
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(40.0), 
                border: Border.all(color: const Color(0xffdadadc)) 
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatInput,
                      decoration: const InputDecoration(
                        hintText: 'Type message...',
                        hintStyle: TextStyle(color: Color(0xffdadadc)),
                        border: InputBorder.none 
                      )
                    )
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffe0d3ff),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xffdfd4ff), 
                        width: 2.0 
                      )
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      color: const Color(0xff3e1ea3),
                      onPressed: () {
                        sendMessage(chatInput.text);
                      }
                    )
                  )
                ]
              )
            )
          )

        ]

      )

    );

  }

  String formatStamp(DateTime dt) {
    final hours = dt.hour.toString().padLeft(2, '0');
    final minutes = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    final formattedHour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final formattedTime = '$formattedHour:$minutes $period';
    return formattedTime;
  }

  void sendMessage(String chat) {
    if (chat.isNotEmpty) {
      setState(() {
        messages
            .add(Message(sender: "User", chat: chat, datetime: DateTime.now()));
      });

      chatInput.clear();
    }
  }
}

class Message {
  String sender;
  String chat;
  DateTime datetime;

  Message({required this.sender, required this.chat, required this.datetime});
}
