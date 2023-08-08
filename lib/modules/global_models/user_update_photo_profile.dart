// To parse this JSON data, do
//
//     final userUpdatePhotoProfileResponse = userUpdatePhotoProfileResponseFromJson(jsonString);

import 'dart:convert';

UserUpdatePhotoProfileResponse userUpdatePhotoProfileResponseFromJson(String str) => UserUpdatePhotoProfileResponse.fromJson(json.decode(str));

String userUpdatePhotoProfileResponseToJson(UserUpdatePhotoProfileResponse data) => json.encode(data.toJson());

class UserUpdatePhotoProfileResponse {
    int? statusCode;
    UserProfileData? profileData;

    UserUpdatePhotoProfileResponse({
        this.statusCode,
        this.profileData,
    });

    UserUpdatePhotoProfileResponse copyWith({
        int? statusCode,
        UserProfileData? data,
    }) => 
        UserUpdatePhotoProfileResponse(
            statusCode: statusCode ?? this.statusCode,
            profileData: data ?? profileData,
        );

    factory UserUpdatePhotoProfileResponse.fromJson(Map<String, dynamic> json) => UserUpdatePhotoProfileResponse(
        statusCode: json["status_code"],
        profileData: json["data"] == null ? null : UserProfileData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": profileData?.toJson(),
    };
}

class UserProfileData {
    int? idUser;
    String? nama;
    dynamic tglLahir;
    String? email;
    dynamic alamat;
    dynamic telepon;
    String? foto;
    String? password;
    String? pin;
    dynamic ktp;
    int? status;
    int? isGoogle;
    int? isCustomer;
    int? mRolesId;
    int? isDeleted;

    UserProfileData({
        this.idUser,
        this.nama,
        this.tglLahir,
        this.email,
        this.alamat,
        this.telepon,
        this.foto,
        this.password,
        this.pin,
        this.ktp,
        this.status,
        this.isGoogle,
        this.isCustomer,
        this.mRolesId,
        this.isDeleted,
    });

    UserProfileData copyWith({
        int? idUser,
        String? nama,
        dynamic tglLahir,
        String? email,
        dynamic alamat,
        dynamic telepon,
        String? foto,
        String? password,
        String? pin,
        dynamic ktp,
        int? status,
        int? isGoogle,
        int? isCustomer,
        int? mRolesId,
        int? isDeleted,
    }) => 
        UserProfileData(
            idUser: idUser ?? this.idUser,
            nama: nama ?? this.nama,
            tglLahir: tglLahir ?? this.tglLahir,
            email: email ?? this.email,
            alamat: alamat ?? this.alamat,
            telepon: telepon ?? this.telepon,
            foto: foto ?? this.foto,
            password: password ?? this.password,
            pin: pin ?? this.pin,
            ktp: ktp ?? this.ktp,
            status: status ?? this.status,
            isGoogle: isGoogle ?? this.isGoogle,
            isCustomer: isCustomer ?? this.isCustomer,
            mRolesId: mRolesId ?? this.mRolesId,
            isDeleted: isDeleted ?? this.isDeleted,
        );

    factory UserProfileData.fromJson(Map<String, dynamic> json) => UserProfileData(
        idUser: json["id_user"],
        nama: json["nama"],
        tglLahir: json["tgl_lahir"],
        email: json["email"],
        alamat: json["alamat"],
        telepon: json["telepon"],
        foto: json["foto"],
        password: json["password"],
        pin: json["pin"],
        ktp: json["ktp"],
        status: json["status"],
        isGoogle: json["is_google"],
        isCustomer: json["is_customer"],
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
        "pin": pin,
        "ktp": ktp,
        "status": status,
        "is_google": isGoogle,
        "is_customer": isCustomer,
        "m_roles_id": mRolesId,
        "is_deleted": isDeleted,
    };
}
