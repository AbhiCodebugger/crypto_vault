// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PortfolioItemModelAdapter extends TypeAdapter<PortfolioItemModel> {
  @override
  final typeId = 0;

  @override
  PortfolioItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PortfolioItemModel(
      coinId: fields[0] as String,
      amount: (fields[1] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, PortfolioItemModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.coinId)
      ..writeByte(1)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PortfolioItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
