import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/data/user_model.dart';
import 'package:instrabaho_app/constant/styles/colors.dart';
import 'package:instrabaho_app/constant/styles/font_styles.dart';
import 'package:instrabaho_app/domain/data/message.dart';
import 'package:instrabaho_app/domain/data/worker_model.dart';
import 'package:instrabaho_app/gen/assets.gen.dart';
import 'package:instrabaho_app/presentation/common/widgets/custom_text.dart';
import 'package:instrabaho_app/presentation/dashboard/pages/job_post_screen.dart';
import 'package:instrabaho_app/presentation/messages/bloc/message_bloc.dart';
import 'package:intl/intl.dart';

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

    _messageController.addListener(_onMessageChanged);
  }

  @override
  void dispose() {
    _messageController.removeListener(_onMessageChanged);
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onMessageChanged() {
    context.read<MessageBloc>().add(
          MessageInputChanged(input: _messageController.text),
        );
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('EEEE, MMMM d').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            CustomText.appBar(context, widget.worker.name),
            CustomText.notes(context, widget.worker.position),
          ],
        ),
        leading: CustomBackButton(
          onTap: () {
            context.pop();
          },
        ),
        leadingWidth: 70,
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

          // Update text controller if state.messageInput changed but controller didn't trigger it
          if (state.messageInput != _messageController.text) {
            final selection = _messageController.selection;
            _messageController.text = state.messageInput;
            // Maintain cursor position if possible
            if (selection.start <= state.messageInput.length) {
              _messageController.selection = selection;
            }
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: state.messages.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Opacity(
                              opacity: 0.3,
                              child: SvgPicture.asset(
                                Assets.bottomNav.navChat,
                                width: 120,
                                height: 120,
                              ),
                            ),
                            const Gap(16),
                            Text(
                              'No messages yet',
                              style: context.textTheme.subheader.copyWith(
                                color: C.textColorSecondary,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              'Start a conversation with ${widget.worker.name}',
                              style: context.textTheme.noteStyle15.copyWith(
                                color: C.textColorTertiary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        cacheExtent: 9999,
                        physics: const ClampingScrollPhysics(),
                        controller: _scrollController,
                        padding: const EdgeInsets.all(8.0),
                        reverse: true,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final message =
                              state.messages.reversed.toList()[index];
                          final isMe = message.sender == currentUser.name;

                          // Check if this is the first message of a new date
                          final bool isNewDate = index == 0 ||
                              _formatDate(message.timestamp) !=
                                  _formatDate(state.messages.reversed
                                      .toList()[index - 1]
                                      .timestamp);

                          return Column(
                            children: [
                              if (isNewDate)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    _formatDate(message.timestamp),
                                    style:
                                        context.textTheme.noteStyle15.copyWith(
                                      color: C.textColorTertiary,
                                    ),
                                  ),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: isMe
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (!isMe) ...[
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundImage: AssetImage(
                                            Assets.categories.category3.path),
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                    Flexible(
                                      child: ChatBubble(
                                        clipper: ChatBubbleClipper3(
                                          type: isMe
                                              ? BubbleType.sendBubble
                                              : BubbleType.receiverBubble,
                                        ),
                                        alignment: isMe
                                            ? Alignment.topRight
                                            : Alignment.topLeft,
                                        margin: EdgeInsets.zero,
                                        backGroundColor: isMe
                                            ? C.blue700
                                            : Colors.grey[200]!,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 4),
                                            if (message.messageType ==
                                                MessageType.text)
                                              Text(message.message,
                                                  style: TextStyle(
                                                    color: isMe
                                                        ? Colors.white
                                                        : Colors.black,
                                                  )),
                                            if (message.messageType ==
                                                MessageType.offer)
                                              Text(
                                                  'Offer: \$${message.message}'),
                                            if (message.messageType ==
                                                MessageType.hire)
                                              Text(
                                                  'Hire request for: ${widget.worker.position}'),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (isMe) ...[
                                      const SizedBox(width: 8),
                                      CircleAvatar(
                                          radius: 16,
                                          backgroundImage: AssetImage(Assets
                                              .categories.category1.path)),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: C.textColorTertiary, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.only(left: 12, right: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: context.textTheme.noteStyle15,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: SvgPicture.asset(
                        state.messageInput.isNotEmpty
                            ? Assets.icon.activeSendButton
                            : Assets.icon.sendButton,
                      ),
                      onPressed: () {
                        if (state.messageInput.isNotEmpty) {
                          context.read<MessageBloc>().add(
                                MessageSend(message: state.messageInput),
                              );
                        }
                        _scrollToBottom();
                      },
                    ),
                  ],
                ),
              ),
              const Gap(30),
            ],
          );
        },
      ),
    );
  }
}
