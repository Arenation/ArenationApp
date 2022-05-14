// To parse this JSON data, do
//
//     final arenas = arenasFromJson(jsonString);

import 'dart:convert';

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

class Arenas {
    Arenas({
        required this.facility,
        required this.id,
        required this.title,
        required this.city,
        required this.department,
        required this.images,
        required this.surfaceType,
        required this.description,
        required this.facilities,
        required this.price,
        required this.reviews,
        required this.admin,
        required this.sport,
    });

    List<dynamic> facility;
    String id;
    String title;
    String city;
    String department;
    List<String> images;
    String surfaceType;
    String description;
    List<String> facilities;
    int price;
    List<Review> reviews;
    Admin admin;
    Admin sport;

    factory Arenas.fromJson(Map<String, dynamic> json) => Arenas(
        facility: List<dynamic>.from(json["facility"].map((x) => x)),
        id: json["_id"],
        title: json["title"],
        city: json["city"],
        department: json["department"],
        images: List<String>.from(json["images"].map((x) => x)),
        surfaceType: json["surfaceType"],
        description: json["description"],
        facilities: List<String>.from(json["facilities"].map((x) => x)),
        price: json["price"],
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        admin: Admin.fromJson(json["admin"]),
        sport: Admin.fromJson(json["sport"]),
    );

    Map<String, dynamic> toJson() => {
        "facility": List<dynamic>.from(facility.map((x) => x)),
        "_id": id,
        "title": title,
        "city": city,
        "department": department,
        "images": List<dynamic>.from(images.map((x) => x)),
        "surfaceType": surfaceType,
        "description": description,
        "facilities": List<dynamic>.from(facilities.map((x) => x)),
        "price": price,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "admin": admin.toJson(),
        "sport": sport.toJson(),
    };
}

class Admin {
    Admin({
        required this.ref,
        required this.id,
        required this.db,
    });

    String ref;
    String id;
    String db;

    factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        ref: json["\u0024ref"],
        id: json["\u0024id"],
        db: json["\u0024db"],
    );

    Map<String, dynamic> toJson() => {
        "\u0024ref": ref,
        "\u0024id": id,
        "\u0024db": db,
    };
}

class Review {
    Review({
        required this.id,
        required this.userId,
        required this.date,
        required this.content,
        required this.qualification,
    });

    String id;
    String userId;
    DateTime date;
    String content;
    double qualification;

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        content: json["content"],
        qualification: json["qualification"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date": date.toIso8601String(),
        "content": content,
        "qualification": qualification,
    };
}
