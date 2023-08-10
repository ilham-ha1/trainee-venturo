// To parse this JSON data, do
//
//     final userAddReviewResponse = userAddReviewResponseFromJson(jsonString);

import 'dart:convert';

UserAddReviewBody userAddReviewResponseFromJson(String str) => UserAddReviewBody.fromJson(json.decode(str));

String userAddReviewResponseToJson(UserAddReviewBody data) => json.encode(data.toJson());

class UserAddReviewBody {
    int? idUser;
    double? score;
    String? type;
    String? review;
    String? image;

    UserAddReviewBody({
        this.idUser,
        this.score,
        this.type,
        this.review,
        this.image,
    });

    UserAddReviewBody copyWith({
        int? idUser,
        double? score,
        String? type,
        String? review,
        String? image,
    }) => 
        UserAddReviewBody(
            idUser: idUser ?? this.idUser,
            score: score ?? this.score,
            type: type ?? this.type,
            review: review ?? this.review,
            image: image ?? this.image,
        );

    factory UserAddReviewBody.fromJson(Map<String, dynamic> json) => UserAddReviewBody(
        idUser: json["id_user"],
        score: json["score"]?.toDouble(),
        type: json["type"],
        review: json["review"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "score": score,
        "type": type,
        "review": review,
        "image": image,
    };
}
