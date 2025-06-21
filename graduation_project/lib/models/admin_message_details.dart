class AdminMessageDetail {
  final String subject;
  final String message;
  final String sentAt;
  final String repliedAt;
  final String adminReply;
  final bool isReadByAdmin;

  AdminMessageDetail({
    required this.subject,
    required this.message,
    required this.sentAt,
    required this.repliedAt,
    required this.adminReply,
    required this.isReadByAdmin,
  });

  factory AdminMessageDetail.fromJson(Map<String, dynamic> json) {
    return AdminMessageDetail(
      subject: json['subject'],
      message: json['message'],
      sentAt: json['sentAt'],
      repliedAt: json['repliedAt'],
      adminReply: json['adminReply'],
      isReadByAdmin: json['isReadByAdmin'],
    );
  }
}
