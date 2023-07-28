import 'package:hive_flutter/hive_flutter.dart';
part 'cart.g.dart';

@HiveType(typeId: 0)
class Cart extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String nama;

  @HiveField(2)
  String? foto;

  @HiveField(3)
  int level;

  @HiveField(4)
  List<int> topping;

  @HiveField(5)
  int jumlah;

  @HiveField(6)
  String? catatan;

  @HiveField(7)
  String? deskripsi;

  @HiveField(8)
  int harga;

  @HiveField(9)
  String kategori;

  Cart({
    required this.id,
    required this.harga,
    required this.level,
    required this.catatan,
    required this.deskripsi,
    required this.foto,
    required this.topping,
    required this.jumlah,
    required this.nama,
    required this.kategori
  });
}
