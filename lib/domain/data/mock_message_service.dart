import 'package:instrabaho_app/domain/data/message.dart';
import 'package:instrabaho_app/domain/data/worker_model.dart';

class MockMessageService {
  static final List<String> _mockReplies = [
    "Hello! Thank you for reaching out.",
    "I'm interested in your offer. Can we discuss the details?",
    "I'm available to start next week.",
    "That sounds good! I accept your offer.",
    "I'll need more information about the job requirements.",
    "What are the working hours?",
    "Do you provide any training?",
    "I'm looking forward to working with you!",
    "Can we schedule an interview?",
    "I have some questions about the position.",
  ];

  static final List<String> _mockOffers = [
    "5000",
    "7500",
    "10000",
    "15000",
    "20000",
    "25000",
    "30000",
    "35000",
    "40000",
    "45000",
  ];

  static String getRandomReply() {
    return _mockReplies[
        (DateTime.now().millisecondsSinceEpoch % _mockReplies.length)];
  }

  static String getRandomOffer() {
    return _mockOffers[
        (DateTime.now().millisecondsSinceEpoch % _mockOffers.length)];
  }

  static Future<Message> simulateUserReply(WorkerModel worker) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return Message.text(
      message: getRandomReply(),
      sender: worker.name,
      receiver: "Current User",
    );
  }

  static Future<Message> simulateUserAcceptOffer(
      WorkerModel worker, String position) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return Message.hire(
      sender: worker.name,
      receiver: "Current User",
      position: position,
      isAccept: true,
    );
  }

  static Future<Message> simulateUserMakeOffer(WorkerModel worker) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return Message.offer(
      amount: getRandomOffer(),
      sender: worker.name,
      receiver: "Current User",
    );
  }
}
