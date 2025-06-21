class AdminMessage {
  final int messageId;
  final String subject;
  final String message;
  final String sentAtDateTime;
  final String? repliedAtDateTime;
  final String adminReply;
  final bool isReadByAdmin;

  AdminMessage({
    required this.messageId,
    required this.subject,
    required this.message,
    required this.sentAtDateTime,
    this.repliedAtDateTime,
    required this.adminReply,
    required this.isReadByAdmin,
  });

  factory AdminMessage.fromJson(Map<String, dynamic> json) {
    return AdminMessage(
      messageId: json['messageId'],
      subject: json['subject'],
      message: json['message'],
      sentAtDateTime: json['sentAtDateTime'],
      repliedAtDateTime: json['repliedAtDateTime'],
      adminReply: json['adminReply'],
      isReadByAdmin: json['isReadByAdmin'],
    );
  }
}
