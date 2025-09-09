// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionTypeFilterAdapter extends TypeAdapter<TransactionTypeFilter> {
  @override
  final int typeId = 1;

  @override
  TransactionTypeFilter read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionTypeFilter.income;
      case 1:
        return TransactionTypeFilter.expense;
      default:
        return TransactionTypeFilter.income;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionTypeFilter obj) {
    switch (obj) {
      case TransactionTypeFilter.income:
        writer.writeByte(0);
        break;
      case TransactionTypeFilter.expense:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionTypeFilterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
