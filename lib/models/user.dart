class User {
  User({
    this.id,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    // this.role,
    this.name,
    this.online,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String username;
  String email;
  String provider;
  bool confirmed;
  bool blocked;
  // Role role;
  String name;
  bool online;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        // role: Role.fromJson(json["role"]),
        name: json["name"],
        online: json["online"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "blocked": blocked,
        // "role": role.toJson(),
        "name": name,
        "online": online,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserCredential {
  String usernameOrEmail;
  String password;

  UserCredential({this.usernameOrEmail, this.password});
}

// class Role {
//     Role({
//         this.id,
//         this.name,
//         this.description,
//         this.type,
//     });

//     int id;
//     String name;
//     String description;
//     String type;

//     factory Role.fromJson(Map<String, dynamic> json) => Role(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         type: json["type"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "description": description,
//         "type": type,
//     };
// }
