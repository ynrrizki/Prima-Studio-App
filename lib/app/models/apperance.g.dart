// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apperance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeAdapter extends TypeAdapter<Apperance> {
  @override
  final int typeId = 0;

  @override
  Apperance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Apperance(
      themeSettings: fields[0] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Apperance obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.themeSettings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
