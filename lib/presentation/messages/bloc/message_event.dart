part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object?> get props => [];
}

class MessageInit extends MessageEvent {
  final WorkerModel worker;

  const MessageInit({required this.worker});

  @override
  List<Object?> get props => [worker];
}

class MessageInputChanged extends MessageEvent {
  final String input;

  const MessageInputChanged({required this.input});

  @override
  List<Object?> get props => [input];
}

class MessageSend extends MessageEvent {
  final String message;

  const MessageSend({required this.message});

  @override
  List<Object> get props => [message];
}

class SimulateUserReply extends MessageEvent {
  final String message;

  const SimulateUserReply({required this.message});

  @override
  List<Object?> get props => [message];
}

class MessageMakeAnOffer extends MessageEvent {
  final String message;

  const MessageMakeAnOffer({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageSendHire extends MessageEvent {}

class MessageSwicthPOV extends MessageEvent {
  final int tabIndex;

  const MessageSwicthPOV({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

class SimulateUserAcceptOffer extends MessageEvent {}
