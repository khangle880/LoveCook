class LoginResponse {
  LoginResponse({
    this.user,
    this.tokens,
  });

  User? user;
  Tokens? tokens;

  LoginResponse copyWith({
    User? user,
    Tokens? tokens,
  }) =>
      LoginResponse(
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

  Access copyWith({
    String? token,
    DateTime? expires,
  }) =>
      Access(
        token: token ?? this.token,
        expires: expires ?? this.expires,
      );
}

class User {
  User({
    this.followingUsers,
    this.followerUsers,
    this.name,
    this.email,
    this.role,
    this.status,
    this.id,
  });

  List<dynamic>? followingUsers;
  List<dynamic>? followerUsers;
  String? name;
  String? email;
  String? role;
  String? status;
  String? id;

  User copyWith({
    List<dynamic>? followingUsers,
    List<dynamic>? followerUsers,
    String? name,
    String? email,
    String? role,
    String? status,
    String? id,
  }) =>
      User(
        followingUsers: followingUsers ?? this.followingUsers,
        followerUsers: followerUsers ?? this.followerUsers,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        status: status ?? this.status,
        id: id ?? this.id,
      );
}
