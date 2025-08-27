class UserModel {
  final String id; // رقم التعريف
  final String firstName; // الاسم الاول
  final String lastName; // اللقب
  final String address; // العنوان
  final String? job; // الوظيفة
  final double? monthlyIncome; // الدخل الشهري
  final double? income; // الدخل
  final double? expense; // المصروف
  final String? registrationNumber; // رقم ريجيستر
  final String? shopName; // اسم المحل
  final String? phoneNumber; // رقم الهاتف
  final String email; // البريد الإلكتروني
  final String password; // كلمة المرور

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    this.job,
    this.monthlyIncome,
    this.income = 0.0,
    this.expense = 0.0,
    this.registrationNumber,
    this.shopName,
    this.phoneNumber,
    required this.email,
   required this.password,
  });

  // Create a UserModel from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      address: json['address'] ?? '',
      job: json['job'],
      monthlyIncome: json['monthlyIncome'] != null
          ? json['monthlyIncome'].toDouble()
          : null,
      income: json['income'] != null ? json['income'].toDouble() : null,
      expense: json['expense'] != null ? json['expense'].toDouble() : null,
      registrationNumber: json['registrationNumber'],
      shopName: json['shopName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'job': job,
      'monthlyIncome': monthlyIncome,
      'income': income,
      'expense': expense,
      'registrationNumber': registrationNumber,
      'shopName': shopName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
    };
  }

  // Create a copy of this UserModel with the given field values changed
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? address,
    String? job,
    double? monthlyIncome,
    double? income,
    double? expense,
    String? registrationNumber,
    String? shopName,
    String? phoneNumber,
    String? email,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      job: job ?? this.job,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      shopName: shopName ?? this.shopName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  /// Updates this user model with values from another user model
  /// Returns a new UserModel with the updated values
  UserModel updateFrom(UserModel user) {
    return copyWith(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      address: user.address,
      job: user.job,
      monthlyIncome: user.monthlyIncome,
      income: user.income,
      expense: user.expense,
      registrationNumber: user.registrationNumber,
      shopName: user.shopName,
      phoneNumber: user.phoneNumber,
      email: user.email,
      password: user.password,
    );
  }
}
