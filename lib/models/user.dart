class UserInfo {
  final String userId;
  final String email;
  final String? userName;
  final String? about;
  final String? userImage;
  final DateTime createdAt;
  final DateTime lastActive;

  UserInfo({
    required this.userId,
    required this.email,
     this.userName,
     this.about,
     this.userImage,
    required this.createdAt,
    required this.lastActive,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userId: json['user_id'] as String ,
      email: json['email'] as String ,
      userName: json['user_name'] as String ,
      about: json['about'] as String ,
      userImage: json['user_image'] as String ,
      createdAt: DateTime.parse(json['created_at']),
      lastActive: DateTime.parse(json['last_active']),
    );
  }

 
}
