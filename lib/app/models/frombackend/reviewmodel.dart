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
}