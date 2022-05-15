import 'dart:convert';

class DataUsers {
    DataUsers({
        required this.status,
        required this.data,
    });

    String status;
    User data;

    factory DataUsers.fromJson(Map<String, dynamic> json) => DataUsers(
        status: json["status"],
        data: User.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}


class User {
    User({
        required this.id,
        required this.names,
        required this.lastnames,
        required this.email,
        required this.password,
        required this.role,
        required this.date,
    });

    String id;
    String names;
    String lastnames;
    String email;
    String password;
    String role;
    DateTime date;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        names: json["names"],
        lastnames: json["lastnames"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "names": names,
        "lastnames": lastnames,
        "email": email,
        "password": password,
        "role": role,
        "date": date.toIso8601String()
    };
}
