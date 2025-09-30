import 'package:hive/hive.dart';

part 'filters.g.dart';

@HiveType(typeId: 1)
enum TransactionTypeFilter {
  @HiveField(0)
  income,

  @HiveField(1)
  expense,
}
enum TransactionDateFilter {
  thisMonth,
  last7Days,
}
