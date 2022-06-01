// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.user,
    this.tokens,
  });

  User? user;
  Tokens? tokens;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: User.fromJson(json["user"]),
      tokens: Tokens.fromJson(json["tokens"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "tokens": tokens?.toJson(),
      };
}

class Tokens {
  Tokens({
    this.access,
    this.refresh,
  });

  Access? access;
  Access? refresh;

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: Access.fromJson(json["access"]),
        refresh: Access.fromJson(json["refresh"]),
      );

  Map<String, dynamic> toJson() => {
        "access": access?.toJson(),
        "refresh": refresh?.toJson(),
      };
}

class Access {
  Access({
    this.token,
    this.expires,
  });

  String? token;
  DateTime? expires;

  factory Access.fromJson(Map<String, dynamic> json) => Access(
        token: json["token"],
        expires: DateTime.parse(json["expires"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expires": expires?.toIso8601String(),
      };
}

class User {
  User({
    this.followingUsers,
    this.followerUsers,
    this.name,
    this.email,
    this.role,
    this.avatarUrl,
    this.bio,
    this.phone,
    this.status,
    this.id,
  });

  List<dynamic>? followingUsers;
  List<dynamic>? followerUsers;
  String? name;
  String? email;
  String? role;
  String? avatarUrl;
  String? bio;
  String? phone;
  String? status;
  String? id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        followingUsers:
            List<dynamic>.from(json["followingUsers"].map((x) => x)),
        followerUsers: List<dynamic>.from(json["followerUsers"].map((x) => x)),
        name: json["name"],
        email: json["email"],
        role: json["role"],
        bio: json["bio"],
        avatarUrl: json["avatarUrl"],
        phone: json["phone"],
        status: json["status"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "followingUsers": followingUsers?.map((x) => x).toList(),
        "followerUsers": followerUsers?.map((x) => x).toList(),
        "name": name,
        "email": email,
        "role": role,
        "avatarUrl": avatarUrl,
        "bio": bio,
        "phone": phone,
        "status": status,
        "id": id,
      };
}
