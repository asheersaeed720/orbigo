class Chat {
  Chat({
    this.id,
    this.text,
    this.users,
    this.channel,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String text;
  Users users;
  String channel;
  DateTime createdAt;
  DateTime updatedAt;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        text: json["text"],
        users: Users.fromJson(json["users"]),
        channel: json["channel"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "users": users.toJson(),
        "channel": channel,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Users {
  Users({
    this.id,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.role,
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
  int role;
  String name;
  bool online;
  DateTime createdAt;
  DateTime updatedAt;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        role: json["role"],
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
        "role": role,
        "name": name,
        "online": online,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
