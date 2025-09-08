part of 'add_transaction_bloc.dart';

@immutable
sealed class AddTransactionsEvent {}

class AddTransactionRequestedEvent extends AddTransactionsEvent {
  final double amount;
  final String currency;
  final DateTime date;
  final String type;
  final String categoryName;
  final int categoryIcon;
  final String? receiptPath;

  AddTransactionRequestedEvent({
    required this.amount,
    required this.currency,
    required this.date,
    required this.type,
    required this.categoryName,
    required this.categoryIcon,
    this.receiptPath,
  });
}

final class PickFileEvent extends AddTransactionsEvent {}

