class ContactMessageDetail {
  final String subject;
  final String message;
  final String sentAt;
  final String repliedAt;
  final String adminReply;

  ContactMessageDetail({
    required this.subject,
    required this.message,
    required this.sentAt,
    required this.repliedAt,
    required this.adminReply,
  });

  factory ContactMessageDetail.fromJson(Map<String, dynamic> json) {
    return ContactMessageDetail(
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
      sentAt: json['sentAt'] ?? '',
      repliedAt: json['repliedAt'] ?? '',
      adminReply: json['adminReply'] ?? '',
    );
  }
}
