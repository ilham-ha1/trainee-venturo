// To parse this JSON data, do
//
//     final userDetailProfileResponse = userDetailProfileResponseFromJson(jsonString);

import 'dart:convert';

UserDetailProfileResponse userDetailProfileResponseFromJson(String str) => UserDetailProfileResponse.fromJson(json.decode(str));

String userDetailProfileResponseToJson(UserDetailProfileResponse data) => json.encode(data.toJson());

class UserDetailProfileResponse {
    int? statusCode;
    UserDetailData? userDetailData;

    UserDetailProfileResponse({
        this.statusCode,
        this.userDetailData,
    });

    UserDetailProfileResponse copyWith({
        int? statusCode,
        UserDetailData? data,
    }) => 
        UserDetailProfileResponse(
            statusCode: statusCode ?? this.statusCode,
            userDetailData: data ?? userDetailData,
        );

    factory UserDetailProfileResponse.fromJson(Map<String, dynamic> json) => UserDetailProfileResponse(
        statusCode: json["status_code"],
        userDetailData: json["data"] == null ? null : UserDetailData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": userDetailData?.toJson(),
    };
}

class UserDetailData {
    int? idUser;
    String? nama;
    String? email;
    String? tglLahir;
    String? alamat;
    String? telepon;
    dynamic foto;
    String? ktp;
    String? pin;
    int? status;
    int? isCustomer;
    int? rolesId;
    String? roles;

    UserDetailData({
        this.idUser,
        this.nama,
        this.email,
        this.tglLahir,
        this.alamat,
        this.telepon,
        this.foto,
        this.ktp,
        this.pin,
        this.status,
        this.isCustomer,
        this.rolesId,
        this.roles,
    });

    UserDetailData copyWith({
        int? idUser,
        String? nama,
        String? email,
        String? tglLahir,
        String? alamat,
        String? telepon,
        dynamic foto,
        String? ktp,
        String? pin,
        int? status,
        int? isCustomer,
        int? rolesId,
        String? roles,
    }) => 
        UserDetailData(
            idUser: idUser ?? this.idUser,
            nama: nama ?? this.nama,
            email: email ?? this.email,
            tglLahir: tglLahir ?? this.tglLahir,
            alamat: alamat ?? this.alamat,
            telepon: telepon ?? this.telepon,
            foto: foto ?? this.foto,
            ktp: ktp ?? this.ktp,
            pin: pin ?? this.pin,
            status: status ?? this.status,
            isCustomer: isCustomer ?? this.isCustomer,
            rolesId: rolesId ?? this.rolesId,
            roles: roles ?? this.roles,
        );

    factory UserDetailData.fromJson(Map<String, dynamic> json) => UserDetailData(
        idUser: json["id_user"],
        nama: json["nama"],
        email: json["email"],
        tglLahir: json["tgl_lahir"],
        alamat: json["alamat"],
        telepon: json["telepon"],
        foto: json["foto"],
        ktp: json["ktp"],
        pin: json["pin"],
        status: json["status"],
        isCustomer: json["is_customer"],
        rolesId: json["roles_id"],
        roles: json["roles"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "nama": nama,
        "email": email,
        "tgl_lahir": tglLahir,
        "alamat": alamat,
        "telepon": telepon,
        "foto": foto,
        "ktp": ktp,
        "pin": pin,
        "status": status,
        "is_customer": isCustomer,
        "roles_id": rolesId,
        "roles": roles,
    };
}
