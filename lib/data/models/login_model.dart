import '../../core/base/base_response.dart';
import '../enum.dart';

class LoginModel extends BaseResponse {
  LoginModel({
    this.user,
    this.tokens,
  });

  User? user;
  Tokens? tokens;

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return LoginModel.fromJson(json) as T;
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    print('Hello WOrld');
    return LoginModel(
      user: User.fromJson(json["user"]),
      tokens: Tokens.fromJson(json["tokens"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "tokens": tokens?.toJson(),
      };
  LoginModel copyWith({
    User? user,
    Tokens? tokens,
  }) =>
      LoginModel(
        user: user ?? this.user,
        tokens: tokens ?? this.tokens,
      );
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

  Tokens copyWith({
    Access? access,
    Access? refresh,
  }) =>
      Tokens(
        access: access ?? this.access,
        refresh: refresh ?? this.refresh,
      );
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

  Access copyWith({
    String? token,
    DateTime? expires,
  }) =>
      Access(
        token: token ?? this.token,
        expires: expires ?? this.expires,
      );
}

class User extends BaseResponse {
  final List<User>? followingUsers;
  final List<User>? followerUsers;
  final String? name;
  final String? email;
  final String? bio;
  final String? avatarUrl;
  final String? phone;
  final Gender? gender;
  final UserRole? role;
  final String? status;
  final String? id;
  User({
    this.followingUsers,
    this.followerUsers,
    this.name,
    this.email,
    this.bio,
    this.avatarUrl,
    this.phone,
    this.gender,
    this.role,
    this.status,
    this.id,
  });

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return User.fromJson(json) as T;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        followingUsers: List<User>.from(
            json["followingUsers"].map((x) => User.fromJson(x))),
        followerUsers:
            List<User>.from(json["followerUsers"].map((x) => User.fromJson(x))),
        name: json["name"],
        email: json["email"],
        bio: json["bio"],
        avatarUrl: json["avatarUrl"],
        phone: json["phone"],
        status: json["status"],
        gender: enumFromString<Gender>(Gender.values, json["gender"]),
        role: enumFromString<UserRole>(UserRole.values, json["role"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "followingUsers": followingUsers?.map((x) => x.toJson()).toList(),
        "followerUsers": followerUsers?.map((x) => x.toJson()).toList(),
        "name": name,
        "email": email,
        "avatarUrl": avatarUrl,
        "bio": bio,
        "phone": phone,
        "status": status,
        "gender": gender?.shortString,
        "role": role?.shortString,
        "id": id,
      };

  User copyWith({
    List<User>? followingUsers,
    List<User>? followerUsers,
    String? name,
    String? email,
    String? bio,
    String? avatarUrl,
    String? phone,
    Gender? gender,
    UserRole? role,
    String? status,
    String? id,
  }) {
    return User(
      followingUsers: followingUsers ?? this.followingUsers,
      followerUsers: followerUsers ?? this.followerUsers,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }
}
