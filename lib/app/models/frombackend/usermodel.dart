enum UserType { client, store }
class UserModel {
  String? id;
  String? name;
  String? email;
  String? address;
  String? wilaya;
  String? commune;
  String? phoneNumber;
  String? fcmToken;
  DateTime? birthDate;
  String? weekend;
  bool? disponible;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserType userType;
  String? profileImage;
  bool verified;
  bool premium;
  double rating;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.address,
    this.wilaya,
    this.commune,
    this.phoneNumber,
    this.fcmToken,
    this.birthDate,
    this.weekend,
    this.disponible,
    this.createdAt,
    this.updatedAt,
    this.userType = UserType.client,
    this.profileImage,
    this.verified = false,
    this.premium = false,
    this.rating = 0.0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      wilaya: json['wilaya'] as String?,
      commune: json['commune'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      fcmToken: json['fcmToken'] as String?,
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'] as String)
          : null,
      weekend: json['weekend'] as String?,
      disponible: json['disponible'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      userType: UserType.values.firstWhere(
        (e) => e.toString().split('.').last == json['userType'],
        orElse: () => UserType.client,
      ),
      profileImage: json['profileImage'] as String?,
      verified: json['verified'] as bool? ?? false,
      premium: json['premium'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'wilaya': wilaya,
      'commune': commune,
      'phoneNumber': phoneNumber,
      'fcmToken': fcmToken,
      'birthDate': birthDate?.toIso8601String(),
      'weekend': weekend,
      'disponible': disponible,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'userType': userType.toString().split('.').last,
      'profileImage': profileImage,
      'verified': verified,
      'premium': premium,
      'rating': rating,
    };
  }

  static UserModel empty() {
    return UserModel(
      id: '',
      name: '',
      email: '',
      address: '',
      wilaya: '',
      commune: '',
      phoneNumber: '',
      fcmToken: '',
      birthDate: null,
      weekend: '',
      disponible: true,
      createdAt: null,
      updatedAt: null,
      userType: UserType.client,
      profileImage: '',
      verified: false,
      premium: false,
      rating: 0.0,
    );
  }
}
