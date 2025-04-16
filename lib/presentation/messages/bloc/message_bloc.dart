import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instrabaho_app/constant/data/user_model.dart';
import 'package:instrabaho_app/domain/data/message.dart';
import 'package:instrabaho_app/domain/data/mock_message_service.dart';
import 'package:instrabaho_app/domain/data/worker_model.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageState()) {
    on<MessageInit>((event, emit) {
      //clear messages first
      emit(state.copyWith(messages: [], status: MessageStatus.initial));
      emit(state.copyWith(worker: event.worker));
    });

    on<MessageSend>((event, emit) async {
      final List<Message> messages = List.from(state.messages);
      final WorkerModel? worker = state.worker;
      if (worker == null) return;

      // Set status to sending
      emit(state.copyWith(status: MessageStatus.sending));

      // Add user message
      final Message userMessage = Message.text(
        message: event.message,
        sender: currentUser.name,
        receiver: worker.name,
      );
      messages.add(userMessage);
      emit(state.copyWith(
        messages: messages,
        status: MessageStatus.sent,
      ));

      // Set status to receiving before simulating reply
      emit(state.copyWith(status: MessageStatus.receiving));

      // Simulate worker reply after a delay
      final Message workerReply =
          await MockMessageService.simulateUserReply(worker);
      messages.add(workerReply);
      emit(state.copyWith(
        messages: messages,
        status: MessageStatus.received,
      ));
    });

    on<SimulateUserReply>((event, emit) async {
      final List<Message> messages = List.from(state.messages);
      final WorkerModel? worker = state.worker;
      if (worker == null) return;

      emit(state.copyWith(status: MessageStatus.receiving));

      final Message newMessage =
          await MockMessageService.simulateUserReply(worker);
      messages.add(newMessage);
      emit(state.copyWith(
        messages: messages,
        status: MessageStatus.received,
      ));
    });

    on<MessageMakeAnOffer>((event, emit) async {
      final List<Message> messages = List.from(state.messages);
      final WorkerModel? worker = state.worker;
      if (worker == null) return;

      // Set status to sending
      emit(state.copyWith(status: MessageStatus.sending));

      final Message newMessage = Message.offer(
        amount: event.message,
        sender: currentUser.name,
        receiver: worker.name,
      );
      messages.add(newMessage);
      emit(state.copyWith(
        messages: messages,
        status: MessageStatus.sent,
      ));

      // Set status to receiving before simulating reply
      emit(state.copyWith(status: MessageStatus.receiving));

      // Simulate worker making a counter offer
      final Message counterOffer =
          await MockMessageService.simulateUserMakeOffer(worker);
      messages.add(counterOffer);
      emit(state.copyWith(
        messages: messages,
        status: MessageStatus.received,
      ));
    });

    on<MessageSendHire>((event, emit) async {
      final List<Message> messages = List.from(state.messages);
      final WorkerModel? worker = state.worker;
      if (worker == null) return;

      // Set status to sending
      emit(state.copyWith(status: MessageStatus.sending));

      final Message newMessage = Message.hire(
        sender: currentUser.name,
        receiver: worker.name,
        position: worker.position,
      );
      messages.add(newMessage);
      emit(state.copyWith(
        messages: messages,
        status: MessageStatus.sent,
      ));

      // Set status to receiving before simulating reply
      emit(state.copyWith(status: MessageStatus.receiving));

      // Simulate worker accepting the hire request
      final Message acceptMessage =
          await MockMessageService.simulateUserAcceptOffer(
        worker,
        worker.position,
      );
      messages.add(acceptMessage);
      emit(state.copyWith(
        messages: messages,
        status: MessageStatus.received,
      ));
    });

    on<MessageSwicthPOV>((event, emit) {
      emit(state.copyWith(tabIndex: event.tabIndex));
    });

    on<SimulateUserAcceptOffer>((event, emit) async {
      final List<Message> messages = List.from(state.messages);
      final WorkerModel? worker = state.worker;
      if (worker == null) return;

      emit(state.copyWith(status: MessageStatus.receiving));

      final Message newMessage =
          await MockMessageService.simulateUserAcceptOffer(
        worker,
        worker.position,
      );
      messages.add(newMessage);
      emit(state.copyWith(
        messages: messages,
        status: MessageStatus.received,
      ));
    });
  }
}
