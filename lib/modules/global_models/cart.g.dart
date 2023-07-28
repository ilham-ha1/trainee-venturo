// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartAdapter extends TypeAdapter<Cart> {
  @override
  final int typeId = 0;

  @override
  Cart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cart(
      id: fields[0] as int,
      harga: fields[8] as int,
      level: fields[3] as int,
      catatan: fields[6] as String?,
      deskripsi: fields[7] as String?,
      foto: fields[2] as String?,
      topping: (fields[4] as List).cast<int>(),
      jumlah: fields[5] as int,
      nama: fields[1] as String,
      kategori: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Cart obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nama)
      ..writeByte(2)
      ..write(obj.foto)
      ..writeByte(3)
      ..write(obj.level)
      ..writeByte(4)
      ..write(obj.topping)
      ..writeByte(5)
      ..write(obj.jumlah)
      ..writeByte(6)
      ..write(obj.catatan)
      ..writeByte(7)
      ..write(obj.deskripsi)
      ..writeByte(8)
      ..write(obj.harga)
      ..writeByte(9)
      ..write(obj.kategori);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
