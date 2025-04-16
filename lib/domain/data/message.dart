class Message {
  final String message;
  final String sender;
  final String receiver;
  final DateTime timestamp;
  final bool isRead;
  final bool isDelivered;
  final bool isAccept;
  final MessageType messageType;
  final List<String> attachments;

  Message({
    required this.message,
    required this.sender,
    required this.receiver,
    required this.timestamp,
    this.isRead = false,
    this.isDelivered = false,
    this.isAccept = false,
    this.messageType = MessageType.text,
    this.attachments = const [],
  });

  // Factory constructor for text messages
  factory Message.text({
    required String message,
    required String sender,
    required String receiver,
  }) {
    return Message(
      message: message,
      sender: sender,
      receiver: receiver,
      timestamp: DateTime.now(),
      messageType: MessageType.text,
    );
  }

  // Factory constructor for offer messages
  factory Message.offer({
    required String amount,
    required String sender,
    required String receiver,
  }) {
    return Message(
      message: amount,
      sender: sender,
      receiver: receiver,
      timestamp: DateTime.now(),
      messageType: MessageType.offer,
    );
  }

  // Factory constructor for hire messages
  factory Message.hire({
    required String sender,
    required String receiver,
    required String position,
    bool isAccept = false,
  }) {
    return Message(
      message:
          "Hello $receiver, I would like to hire you as $position. Please let me know if you are interested.",
      sender: sender,
      receiver: receiver,
      timestamp: DateTime.now(),
      messageType: MessageType.hire,
      isAccept: isAccept,
    );
  }

  // Copy with method for immutable updates
  Message copyWith({
    String? message,
    String? sender,
    String? receiver,
    DateTime? timestamp,
    bool? isRead,
    bool? isDelivered,
    bool? isAccept,
    MessageType? messageType,
    List<String>? attachments,
  }) {
    return Message(
      message: message ?? this.message,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      isDelivered: isDelivered ?? this.isDelivered,
      isAccept: isAccept ?? this.isAccept,
      messageType: messageType ?? this.messageType,
      attachments: attachments ?? this.attachments,
    );
  }
}

enum MessageType { offer, text, hire }
