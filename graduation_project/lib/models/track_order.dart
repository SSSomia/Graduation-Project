class TrackingModel {
  final int orderId;
  final String currentStatus;
  final List<TrackingHistory> trackingHistory;

  TrackingModel({
    required this.orderId,
    required this.currentStatus,
    required this.trackingHistory,
  });

  factory TrackingModel.fromJson(Map<String, dynamic> json) {
    return TrackingModel(
      orderId: json['orderId'],
      currentStatus: json['currentStatus'],
      trackingHistory: (json['trackingHistory'] as List)
          .map((e) => TrackingHistory.fromJson(e))
          .toList(),
    );
  }
}

class TrackingHistory {
  final String status;
  final String changedAt;

  TrackingHistory({required this.status, required this.changedAt});

  factory TrackingHistory.fromJson(Map<String, dynamic> json) {
    return TrackingHistory(
      status: json['status'],
      changedAt: json['changedAt'],
    );
  }
}
