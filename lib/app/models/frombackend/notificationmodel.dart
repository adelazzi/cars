class NotificationModel {
  final int userId;
  final String title;
  final bool seen;
  final String content;
  final DateTime createdAt;

  NotificationModel({
    required this.userId,
    required this.title,
    this.seen = false,
    required this.content,
    required this.createdAt,
  });

  // Factory method to create a NotificationModel from a JSON object
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      userId: json['user_id'],
      title: json['title'],
      seen: json['seen'] ?? false,
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Method to convert a NotificationModel to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'title': title,
      'seen': seen,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }
}