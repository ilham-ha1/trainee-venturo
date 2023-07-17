class User {
  final int? id;
  final String? nama;
  final String? humanisFoto;
  final String? jabatan;

  User({
    this.id,
    this.nama,
    this.humanisFoto,
    this.jabatan,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      humanisFoto: json['humanisFoto'],
      jabatan: json['jabatan'],
    );
  }
}

class Data {
  final User? user;
  final bool isLogin;

  Data({
    this.user,
    required this.isLogin,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: User.fromJson(json),
      isLogin: true,
    );
  }
}
