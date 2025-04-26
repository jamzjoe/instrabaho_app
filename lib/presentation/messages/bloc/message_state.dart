part of 'message_bloc.dart';

enum MessageStatus { initial, sending, sent, receiving, received }

class MessageState extends Equatable {
  final List<Message> messages;
  final WorkerModel? worker;
  final int tabIndex;
  final MessageStatus status;
  final String messageInput;

  const MessageState({
    this.messages = const [],
    this.worker,
    this.tabIndex = 0,
    this.status = MessageStatus.initial,
    this.messageInput = '',
  });

  MessageState copyWith({
    List<Message>? messages,
    WorkerModel? worker,
    int? tabIndex,
    MessageStatus? status,
    String? messageInput,
  }) {
    return MessageState(
      messages: messages ?? this.messages,
      worker: worker ?? this.worker,
      tabIndex: tabIndex ?? this.tabIndex,
      status: status ?? this.status,
      messageInput: messageInput ?? this.messageInput,
    );
  }

  @override
  List<Object?> get props => [messages, worker, tabIndex, status, messageInput];
}
