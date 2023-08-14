// To parse this JSON data, do
//
//     final userAllReviewResponse = userAllReviewResponseFromJson(jsonString);

import 'dart:convert';

UserAllReviewResponse userAllReviewResponseFromJson(String str) => UserAllReviewResponse.fromJson(json.decode(str));

String userAllReviewResponseToJson(UserAllReviewResponse data) => json.encode(data.toJson());

class UserAllReviewResponse {
    int? statusCode;
    List<Review>? data;

    UserAllReviewResponse({
        this.statusCode,
        this.data,
    });

    UserAllReviewResponse copyWith({
        int? statusCode,
        List<Review>? data,
    }) => 
        UserAllReviewResponse(
            statusCode: statusCode ?? this.statusCode,
            data: data ?? this.data,
        );

    factory UserAllReviewResponse.fromJson(Map<String, dynamic> json) => UserAllReviewResponse(
        statusCode: json["status_code"],
        data: json["data"] == null ? [] : List<Review>.from(json["data"]!.map((x) => Review.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Review {
    int? idReview;
    int? idUser;
    String? nama;
    double? score;
    String? type;
    String? review;
    String? image;
    int? createdAt;

    Review({
        this.idReview,
        this.idUser,
        this.nama,
        this.score,
        this.type,
        this.review,
        this.image,
        this.createdAt,
    });

    Review copyWith({
        int? idReview,
        int? idUser,
        String? nama,
        double? score,
        String? type,
        String? review,
        String? image,
        int? createdAt,
    }) => 
        Review(
            idReview: idReview ?? this.idReview,
            idUser: idUser ?? this.idUser,
            nama: nama ?? this.nama,
            score: score ?? this.score,
            type: type ?? this.type,
            review: review ?? this.review,
            image: image ?? this.image,
            createdAt: createdAt ?? this.createdAt,
        );

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        idReview: json["id_review"],
        idUser: json["id_user"],
        nama: json["nama"],
        score: json["score"]?.toDouble(),
        type: json["type"],
        review: json["review"],
        image: json["image"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id_review": idReview,
        "id_user": idUser,
        "nama": nama,
        "score": score,
        "type": type,
        "review": review,
        "image": image,
        "created_at": createdAt,
    };
}
