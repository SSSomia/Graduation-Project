class TrackOrderModel {
  final int orderId;
  final String currentStatus;
  final List<String> trackingHistory;

  TrackOrderModel({
    required this.orderId,
    required this.currentStatus,
    required this.trackingHistory,
  });

  factory TrackOrderModel.fromJson(Map<String, dynamic> json) {
    return TrackOrderModel(
      orderId: json['orderId'],
      currentStatus: json['currentStatus'],
      trackingHistory: List<String>.from(json['trackingHistory']),
    );
  }
}
