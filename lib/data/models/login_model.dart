import '../../core/base/base_response.dart';
import '../enum.dart';

class LoginModel extends BaseResponse {
  LoginModel({
    this.user,
    this.tokens,
  });

  final User? user;
  final Tokens? tokens;

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

  @override
  List<Object?> get props => [user, tokens];
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
  final List<String>? followingUsers;
  final List<String>? followerUsers;
  final String? name;
  final String? email;
  final String? bio;
  final String? avatarUrl;
  final String? phone;
  final Gender? gender;
  final String? languageSetting;
  final UserRole? role;
  final String? status;
  final String? id;
  final int? totalRecipes;
  final int? totalProducts;
  final int? totalPosts;
  User({
    this.totalRecipes,
    this.totalProducts,
    this.totalPosts,
    this.followingUsers,
    this.followerUsers,
    this.name,
    this.email,
    this.bio,
    this.avatarUrl,
    this.phone,
    this.gender,
    this.languageSetting,
    this.role,
    this.status,
    this.id,
  });

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return User.fromJson(json) as T;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        followingUsers: json["followingUsers"] == null
            ? null
            : List<String>.from(json["followingUsers"]?.map((x) => x)),
        followerUsers: json["followerUsers"] == null
            ? null
            : List<String>.from(json["followerUsers"]?.map((x) => x)),
        name: json["name"],
        email: json["email"] ?? '',
        bio: json["bio"] ?? '',
        avatarUrl: json["avatarUrl"] ?? '',
        phone: json["phone"] ?? '',
        status: json["status"],
        languageSetting: json["languageSetting"],
        gender: enumFromString<Gender>(Gender.values, json["gender"]),
        role: enumFromString<UserRole>(UserRole.values, json["role"]),
        id: json["id"],
        totalPosts: json["totalPosts"]?.toInt(),
        totalRecipes: json["totalRecipes"]?.toInt(),
        totalProducts: json["totalProducts"]?.toInt(),
      );

  Map<String, dynamic> toJson() => {
        "followingUsers": followingUsers?.map((x) => x).toList(),
        "followerUsers": followerUsers?.map((x) => x).toList(),
        "name": name,
        "email": email,
        "avatarUrl": avatarUrl,
        "bio": bio,
        "phone": phone,
        "status": status,
        "gender": gender?.shortString,
        "languageSetting": languageSetting,
        "role": role?.shortString,
        "id": id,
      };

  @override
  List<Object?> get props => [
        followingUsers,
        followerUsers,
        name,
        email,
        bio,
        avatarUrl,
        phone,
        gender,
        role,
        languageSetting,
        status,
        id,
      ];

  User copyWith({
    List<String>? followingUsers,
    List<String>? followerUsers,
    String? name,
    String? email,
    String? bio,
    String? avatarUrl,
    String? phone,
    Gender? gender,
    String? languageSetting,
    UserRole? role,
    String? status,
    String? id,
    int? totalRecipes,
    int? totalProducts,
    int? totalPosts,
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
      languageSetting: languageSetting ?? this.languageSetting,
      role: role ?? this.role,
      status: status ?? this.status,
      id: id ?? this.id,
      totalRecipes: totalRecipes ?? this.totalRecipes,
      totalProducts: totalProducts ?? this.totalProducts,
      totalPosts: totalPosts ?? this.totalPosts,
    );
  }
}
