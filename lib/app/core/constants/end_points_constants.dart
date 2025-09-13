class EndPointsConstants {
  static const String baseUrl = "http://127.0.0.1:8000";

  static const String car = "car";
  static const String category = "category";
  static const String product = "product";
  static const String ads = "ads";
  static const String review = "review";
  static const String order = "order";
  static const String user = "user";
  static const String notification = "notification";
  // User Endpoints
  static const String userApi = "$baseUrl/user/api";
  static const String login = "$userApi/login/";
  static const String register = "$userApi/register/";
  static const String logout = "$userApi/logout/";
  static const String changePassword = "$userApi/change-password/";
  static const String checkUsername = "$userApi/check-username/";
  // Car Endpoints
  static const String carApi = "$baseUrl/car/api/";

  // Review Endpoints
  static const String reviewApi = "$baseUrl/review/api/";

  // Order Endpoints
  static const String orderApi = "$baseUrl/order/api/";

  // Notification Endpoints
  static const String notificationApi = "$baseUrl/notification/api/";
  static const String seen = "/seen/";
  // Ads Endpoints
  static const String adsApi = "$baseUrl/ads/api/";

  // Category Endpoints
  static const String categoryApi = "$baseUrl/category/api/";

  // Product Endpoints
  static const String productApi = "$baseUrl/product/api/";

  static String getDetails(String endpoint, String id) =>
      "$baseUrl$endpoint/$id";
  static String markerAsSeen(String id) => "$baseUrl$notificationApi$id$seen";
}
