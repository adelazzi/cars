import 'package:cars/app/core/services/http_client_service.dart';

class Review {
  final int clientId;
  final int storeId;
  final int rating;
  final String comment;
  final DateTime createdAt;

  Review({
    required this.clientId,
    required this.storeId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  // Factory method to create a Review from a JSON object
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      clientId: json['client_id'],
      storeId: json['store_id'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Method to convert a Review to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'client_id': clientId,
      'store_id': storeId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }



  /////// API Methods ///////
  static Future<List<Review>> fetchAllReviews(int storeId) async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/reviews?store_id=$storeId',
      requestType: HttpRequestTypes.get,
      onError: (errors, apiResponse) {
        throw Exception('Failed to fetch reviews: ${errors.join(', ')}');
      },
    );

    if (response != null && response.body is List) {
      return (response.body as List)
          .map((reviewJson) => Review.fromJson(reviewJson))
          .toList();
    } else {
      throw Exception('Unexpected response format');
    }
  }

  static Future<void> updateReview(int reviewId, Review updatedReview) async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/reviews/$reviewId',
      requestType: HttpRequestTypes.put,
      data: updatedReview.toJson(),
      onError: (errors, apiResponse) {
        throw Exception('Failed to update review: ${errors.join(', ')}');
      },
    );

    if (response == null || response.statusCode != 200) {
      throw Exception('Failed to update review: Unexpected response');
    }
  }

  static Future<void> deleteReview(int reviewId) async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/reviews/$reviewId',
      requestType: HttpRequestTypes.delete,
      onError: (errors, apiResponse) {
        throw Exception('Failed to delete review: ${errors.join(', ')}');
      },
    );

    if (response == null || response.statusCode != 200) {
      throw Exception('Failed to delete review: Unexpected response');
    }
  }

}