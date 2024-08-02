class ActivityLogEntry {
  final String activityType;
  final DateTime timestamp;
  final String details;

  ActivityLogEntry({
    required this.activityType,
    required this.timestamp,
    required this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'activityType': activityType,
      'timestamp': timestamp.toIso8601String(),
      'details': details,
    };
  }

  @override
  String toString() {
    return '$activityType at ${timestamp.toIso8601String()}: $details';
  }
}
