import 'package:hive_flutter/hive_flutter.dart';
part 'cart.g.dart';

@HiveType(typeId: 0)
class Cart extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? nama;

  @HiveField(2)
  String? foto;

  @HiveField(3)
  int? level;

  @HiveField(4)
  List<int>? topping;

  @HiveField(5)
  int? jumlah;

  @HiveField(6)
  String? catatan;

  @HiveField(7)
  String? deskripsi;

  @HiveField(8)
  int? harga;

  @HiveField(9)
  String? kategori;

  @HiveField(10)
  List<int>? toppingPrice;

  @HiveField(11)
  int? levelPrice;

  Cart(
      { this.id,
       this.harga,
       this.level,
       this.catatan,
       this.deskripsi,
       this.foto,
       this.topping,
       this.jumlah,
       this.nama,
       this.kategori,
       this.toppingPrice,
       this.levelPrice,
      });
}
