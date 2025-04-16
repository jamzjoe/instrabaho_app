import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/data/user_model.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';
import 'package:instrabaho_app/domain/data/message.dart';
import 'package:instrabaho_app/domain/data/worker_model.dart';
import 'package:instrabaho_app/presentation/messages/bloc/message_bloc.dart';

enum MessageStatus { initial, sending, sent, receiving, received }

class MessageConversation extends StatefulWidget {
  final WorkerModel worker;

  const MessageConversation({
    super.key,
    required this.worker,
  });

  @override
  State<MessageConversation> createState() => _MessageConversationState();
}

class _MessageConversationState extends State<MessageConversation> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MessageBloc>().add(MessageInit(worker: widget.worker));
    _scrollController.addListener(() {
      // Keep track of scroll position
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() async {
    if (_scrollController.hasClients) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(
          milliseconds:
              (_scrollController.position.maxScrollExtent / 2).round(),
        ),
        curve: Curves.easeOutCirc,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.worker.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              context.read<MessageBloc>().add(
                    MessageSwicthPOV(
                      tabIndex: context.read<MessageBloc>().state.tabIndex == 0
                          ? 1
                          : 0,
                    ),
                  );
            },
          ),
        ],
      ),
      body: BlocConsumer<MessageBloc, MessageState>(
        listenWhen: (previous, current) {
          return previous.messages.length != current.messages.length ||
              previous.status != current.status;
        },
        listener: (context, state) {
          if (state.status == MessageStatus.received ||
              state.status == MessageStatus.sent) {
            Future.delayed(const Duration(milliseconds: 100), () {
              _scrollToBottom();
            });
          }
          if (state.status == MessageStatus.sending) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sending message...'),
                duration: Duration(seconds: 1),
              ),
            );
          }
          if (state.status == MessageStatus.sent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Message sent!'),
                duration: Duration(seconds: 1),
              ),
            );
          }
          if (state.status == MessageStatus.receiving) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Receiving message...'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  cacheExtent: 9999,
                  physics: const ClampingScrollPhysics(),
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8.0),
                  reverse: true,
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages.reversed.toList()[index];
                    final isMe = message.sender == currentUser.name;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue[100] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.sender,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (message.messageType == MessageType.text)
                              Text(message.message),
                            if (message.messageType == MessageType.offer)
                              Text('Offer: \$${message.message}'),
                            if (message.messageType == MessageType.hire)
                              Text(
                                  'Hire request for: ${widget.worker.position}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        if (_messageController.text.isNotEmpty) {
                          context.read<MessageBloc>().add(
                                MessageSend(message: _messageController.text),
                              );
                          _messageController.clear();
                        }
                        _scrollToBottom();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Make an Offer'),
                            content: TextField(
                              controller: _messageController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Enter amount',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (_messageController.text.isNotEmpty) {
                                    context.read<MessageBloc>().add(
                                          MessageMakeAnOffer(
                                            message: _messageController.text,
                                          ),
                                        );
                                    _messageController.clear();
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Send'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.monetization_on),
                      label: const Text('Make Offer'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<MessageBloc>().add(
                              MessageSendHire(),
                            );
                        context.pushReplacementNamed(
                            RouterNames.jobConfirmedScreen);
                      },
                      icon: const Icon(Icons.person_add),
                      label: const Text('Hire'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
