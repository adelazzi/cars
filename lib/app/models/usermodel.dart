class UserModel {
  String? id;
  String? name;
  String? familyName;
  String? phoneNumber;
  String? address;
  String? token;
  String? fcmToken;
  String? imageProfileUrl;

  UserModel({
    this.id,
    this.name,
    this.familyName,
    this.phoneNumber,
    this.address,
    this.token,
    this.fcmToken,
    this.imageProfileUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      familyName: json['familyName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      token: json['token'] as String?, // Safely handle missing or null token
      fcmToken:
          json['fcmToken'] as String?, // Safely handle missing or null fcmToken
      imageProfileUrl: json['imageProfileUrl']
          as String?, // Safely handle missing or null imageProfileUrl
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'familyName': familyName,
      'phoneNumber': phoneNumber,
      'address': address,
      'token': token,
      'fcmToken': fcmToken,
      'imageProfileUrl': imageProfileUrl,
    };
  }
  static UserModel empty() {
    return UserModel(
      id: '',
      name: '',
      familyName: '',
      phoneNumber: '',
      address: '',
      token: '',
      fcmToken: '',
      imageProfileUrl: '',
    );
  }
}
