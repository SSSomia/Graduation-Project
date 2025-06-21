class MessageModel {
  final int messageId;
  final String subject;
  final String sentAt;
  final bool hasReply;

  MessageModel({
    required this.messageId,
    required this.subject,
    required this.sentAt,
    required this.hasReply,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json['messageId'],
      subject: json['subject'],
      sentAt: json['sentAt'],
      hasReply: json['hasReply'],
    );
  }
}
