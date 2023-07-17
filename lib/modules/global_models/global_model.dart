// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LoginResponse welcomeFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String welcomeToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    int statusCode;
    Data data;

    LoginResponse({
        required this.statusCode,
        required this.data,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data.toJson(),
    };
}

class Data {
    User user;
    String token;

    Data({
        required this.user,
        required this.token,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
    };
}

class User {
    int? idUser;
    String? email;
    String? nama;
    String? pin;
    dynamic foto;
    int? mRolesId;
    int? isGoogle;
    int? isCustomer;
    String? roles;
    Akses akses;

    User({
        required this.idUser,
        required this.email,
        required this.nama,
        required this.pin,
        this.foto,
        required this.mRolesId,
        required this.isGoogle,
        required this.isCustomer,
        required this.roles,
        required this.akses,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["id_user"],
        email: json["email"],
        nama: json["nama"],
        pin: json["pin"],
        foto: json["foto"],
        mRolesId: json["m_roles_id"],
        isGoogle: json["is_google"],
        isCustomer: json["is_customer"],
        roles: json["roles"],
        akses: Akses.fromJson(json["akses"]),
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "email": email,
        "nama": nama,
        "pin": pin,
        "foto": foto,
        "m_roles_id": mRolesId,
        "is_google": isGoogle,
        "is_customer": isCustomer,
        "roles": roles,
        "akses": akses.toJson(),
    };
}

class Akses {
    bool authUser;
    bool authAkses;
    bool settingMenu;
    bool settingCustomer;
    bool settingPromo;
    bool settingDiskon;
    bool settingVoucher;
    bool laporanMenu;
    bool laporanCustomer;

    Akses({
        required this.authUser,
        required this.authAkses,
        required this.settingMenu,
        required this.settingCustomer,
        required this.settingPromo,
        required this.settingDiskon,
        required this.settingVoucher,
        required this.laporanMenu,
        required this.laporanCustomer,
    });

    factory Akses.fromJson(Map<String, dynamic> json) => Akses(
        authUser: json["auth_user"],
        authAkses: json["auth_akses"],
        settingMenu: json["setting_menu"],
        settingCustomer: json["setting_customer"],
        settingPromo: json["setting_promo"],
        settingDiskon: json["setting_diskon"],
        settingVoucher: json["setting_voucher"],
        laporanMenu: json["laporan_menu"],
        laporanCustomer: json["laporan_customer"],
    );

    Map<String, dynamic> toJson() => {
        "auth_user": authUser,
        "auth_akses": authAkses,
        "setting_menu": settingMenu,
        "setting_customer": settingCustomer,
        "setting_promo": settingPromo,
        "setting_diskon": settingDiskon,
        "setting_voucher": settingVoucher,
        "laporan_menu": laporanMenu,
        "laporan_customer": laporanCustomer,
    };
}
