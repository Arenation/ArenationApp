// To parse this JSON data, do
//
//     final arenas = arenasFromJson(jsonString);

import 'dart:convert';

Arenas arenasFromJson(String str) => Arenas.fromJson(json.decode(str));

String arenasToJson(Arenas data) => json.encode(data.toJson());

class DataResponseArenas {

  DataResponseArenas({
    required this.data,
  });

  List<Arenas> data;

  factory DataResponseArenas.fromJson(Map<String, dynamic> json) => DataResponseArenas(
    data: List<Arenas>.from(json["data"].map((x) => Arenas.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataArena {
    DataArena({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    Arenas data;

    factory DataArena.fromJson(Map<String, dynamic> json) => DataArena(
        status: json["status"],
        message: json["message"],
        data: Arenas.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Arenas {
    Arenas({
        required this.id,
        required this.sportId,
        required this.title,
        required this.city,
        required this.department,
        required this.images,
        required this.surfaceType,
        required this.description,
        required this.facilities,
        required this.price,
        required this.reviews
    });

    String id;
    SportId sportId;
    String title;
    String city;
    String department;
    List<String> images;
    String surfaceType;
    String description;
    List<String> facilities;
    int price;
    List<Review> reviews;

    factory Arenas.fromJson(Map<String, dynamic> json) => Arenas(
        id: json["_id"],
        sportId: SportId.fromJson(json["sportId"]),
        title: json["title"],
        city: json["city"],
        department: json["department"],
        images: List<String>.from(json["images"].map((x) => x)),
        surfaceType: json["surfaceType"],
        description: json["description"],
        facilities: List<String>.from(json["facilities"].map((x) => x)),
        price: json["price"],
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "sportId": sportId.toJson(),
        "title": title,
        "city": city,
        "department": department,
        "images": List<dynamic>.from(images.map((x) => x)),
        "surfaceType": surfaceType,
        "description": description,
        "facilities": List<dynamic>.from(facilities.map((x) => x)),
        "price": price,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
    };
}

class Review {
    Review({
      required this.userId,
      required this.date,
      required this.content,
      required this.qualification,
    });

    String userId;
    DateTime date;
    String content;
    double qualification;

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        content: json["content"],
        qualification: json["qualification"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "date": date.toIso8601String(),
        "content": content,
        "qualification": qualification,
    };
}

class SportId {
    SportId({
        required this.id,
        required this.name,
        required this.players,
    });

    String id;
    String name;
    int players;

    factory SportId.fromJson(Map<String, dynamic> json) => SportId(
        id: json["_id"],
        name: json["name"],
        players: json["players"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "players": players,
    };
}

class Errors {
    Errors({
        required this.errors,
    });

    List<Error> errors;

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
    };
}

class Error {
    Error({
        required this.msg,
    });

    String msg;

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
    };
}