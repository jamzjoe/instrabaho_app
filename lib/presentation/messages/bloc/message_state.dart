part of 'message_bloc.dart';

enum MessageStatus { initial, sending, sent, receiving, received }

class MessageState extends Equatable {
  final List<Message> messages;
  final WorkerModel? worker;
  final int tabIndex;
  final MessageStatus status;

  const MessageState({
    this.messages = const [],
    this.worker,
    this.tabIndex = 0,
    this.status = MessageStatus.initial,
  });

  MessageState copyWith({
    List<Message>? messages,
    WorkerModel? worker,
    int? tabIndex,
    MessageStatus? status,
  }) {
    return MessageState(
      messages: messages ?? this.messages,
      worker: worker ?? this.worker,
      tabIndex: tabIndex ?? this.tabIndex,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [messages, worker, tabIndex, status];
}
