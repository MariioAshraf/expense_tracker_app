import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/filters.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String currency;

  @HiveField(3)
  double? convertedAmount;

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final TransactionTypeFilter type;

  @HiveField(6)
  final String categoryName;

  @HiveField(7)
  final int categoryIcon;

  @HiveField(8)
  final String? receiptPath;

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'amount': amount,
      'date': date.toIso8601String(),
      'categoryName': categoryName,
      'categoryIcon': categoryIcon,
      'currency': currency,
      'receiptPath': receiptPath,
      'convertedAmount': convertedAmount,
    };
  }

  TransactionModel({
    String? id,
    required this.amount,
    required this.currency,
    this.convertedAmount,
    required this.date,
    required this.type,
    required this.categoryName,
    required this.categoryIcon,
    this.receiptPath,
  }) : id = id ?? const Uuid().v4();
}
