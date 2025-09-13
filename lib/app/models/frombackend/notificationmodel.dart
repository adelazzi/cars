import 'package:cars/app/core/services/http_client_service.dart';
import 'package:cars/app/models/api_response.dart';

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



  /////// API Methods ///////

  // Fetch all notifications for a specific user by user ID
  static Future<List<NotificationModel>> fetchAllByUserId(int userId) async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/notifications',
      requestType: HttpRequestTypes.get,
      queryParameters: {'user_id': userId},
    );

    if (response != null && response.requestStatus == RequestStatus.success) {
      final List<dynamic> data = response.body;
      return data.map((json) => NotificationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch notifications');
    }
  }

  // Mark a notification as seen by its ID
  static Future<bool> markAsSeen(int notificationId) async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/notifications/$notificationId/seen',
      requestType: HttpRequestTypes.patch,
    );

    if (response != null && response.requestStatus == RequestStatus.success) {
      return true;
    } else {
      throw Exception('Failed to mark notification as seen');
    }
  }




}