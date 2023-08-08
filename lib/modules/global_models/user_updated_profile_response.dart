// To parse this JSON data, do
//
//     final userUpdatedProfileResponse = userUpdatedProfileResponseFromJson(jsonString);

import 'dart:convert';

UserUpdatedProfileResponse userUpdatedProfileResponseFromJson(String str) => UserUpdatedProfileResponse.fromJson(json.decode(str));

String userUpdatedProfileResponseToJson(UserUpdatedProfileResponse data) => json.encode(data.toJson());

class UserUpdatedProfileResponse {
    int? statusCode;
    Data? data;

    UserUpdatedProfileResponse({
        this.statusCode,
        this.data,
    });

    UserUpdatedProfileResponse copyWith({
        int? statusCode,
        Data? data,
    }) => 
        UserUpdatedProfileResponse(
            statusCode: statusCode ?? this.statusCode,
            data: data ?? this.data,
        );

    factory UserUpdatedProfileResponse.fromJson(Map<String, dynamic> json) => UserUpdatedProfileResponse(
        statusCode: json["status_code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data?.toJson(),
    };
}

class Data {
    int? idUser;
    String? nama;
    dynamic tglLahir;
    String? email;
    String? alamat;
    String? telepon;
    dynamic foto;
    String? password;
    dynamic ktp;
    int? status;
    int? isGoogle;
    int? mRolesId;
    int? isDeleted;

    Data({
        this.idUser,
        this.nama,
        this.tglLahir,
        this.email,
        this.alamat,
        this.telepon,
        this.foto,
        this.password,
        this.ktp,
        this.status,
        this.isGoogle,
        this.mRolesId,
        this.isDeleted,
    });

    Data copyWith({
        int? idUser,
        String? nama,
        dynamic tglLahir,
        String? email,
        String? alamat,
        String? telepon,
        dynamic foto,
        String? password,
        dynamic ktp,
        int? status,
        int? isGoogle,
        int? mRolesId,
        int? isDeleted,
    }) => 
        Data(
            idUser: idUser ?? this.idUser,
            nama: nama ?? this.nama,
            tglLahir: tglLahir ?? this.tglLahir,
            email: email ?? this.email,
            alamat: alamat ?? this.alamat,
            telepon: telepon ?? this.telepon,
            foto: foto ?? this.foto,
            password: password ?? this.password,
            ktp: ktp ?? this.ktp,
            status: status ?? this.status,
            isGoogle: isGoogle ?? this.isGoogle,
            mRolesId: mRolesId ?? this.mRolesId,
            isDeleted: isDeleted ?? this.isDeleted,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idUser: json["id_user"],
        nama: json["nama"],
        tglLahir: json["tgl_lahir"],
        email: json["email"],
        alamat: json["alamat"],
        telepon: json["telepon"],
        foto: json["foto"],
        password: json["password"],
        ktp: json["ktp"],
        status: json["status"],
        isGoogle: json["is_google"],
        mRolesId: json["m_roles_id"],
        isDeleted: json["is_deleted"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "nama": nama,
        "tgl_lahir": tglLahir,
        "email": email,
        "alamat": alamat,
        "telepon": telepon,
        "foto": foto,
        "password": password,
        "ktp": ktp,
        "status": status,
        "is_google": isGoogle,
        "m_roles_id": mRolesId,
        "is_deleted": isDeleted,
    };
}
