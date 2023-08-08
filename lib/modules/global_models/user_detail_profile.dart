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
            userDetailData: data ?? this.userDetailData,
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
    String? alamat;
    String? telepon;
    dynamic tglLahir;
    dynamic foto;
    dynamic ktp;
    int? status;
    int? mRolesId;

    UserDetailData({
        this.idUser,
        this.nama,
        this.email,
        this.alamat,
        this.telepon,
        this.tglLahir,
        this.foto,
        this.ktp,
        this.status,
        this.mRolesId,
    });

    UserDetailData copyWith({
        int? idUser,
        String? nama,
        String? email,
        String? alamat,
        String? telepon,
        dynamic tglLahir,
        dynamic foto,
        dynamic ktp,
        int? status,
        int? mRolesId,
    }) => 
        UserDetailData(
            idUser: idUser ?? this.idUser,
            nama: nama ?? this.nama,
            email: email ?? this.email,
            alamat: alamat ?? this.alamat,
            telepon: telepon ?? this.telepon,
            tglLahir: tglLahir ?? this.tglLahir,
            foto: foto ?? this.foto,
            ktp: ktp ?? this.ktp,
            status: status ?? this.status,
            mRolesId: mRolesId ?? this.mRolesId,
        );

    factory UserDetailData.fromJson(Map<String, dynamic> json) => UserDetailData(
        idUser: json["id_user"],
        nama: json["nama"],
        email: json["email"],
        alamat: json["alamat"],
        telepon: json["telepon"],
        tglLahir: json["tgl_lahir"],
        foto: json["foto"],
        ktp: json["ktp"],
        status: json["status"],
        mRolesId: json["m_roles_id"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "nama": nama,
        "email": email,
        "alamat": alamat,
        "telepon": telepon,
        "tgl_lahir": tglLahir,
        "foto": foto,
        "ktp": ktp,
        "status": status,
        "m_roles_id": mRolesId,
    };
}
