part of 'get_transactions_bloc.dart';

@immutable
sealed class GetTransactionsState {}

final class GetTransactionsInitial extends GetTransactionsState {}
final class CalculateTotalsSuccess extends GetTransactionsState {
  final Totals totals;
  CalculateTotalsSuccess(this.totals);
}

class GetTransactionsLoading extends GetTransactionsState {}

class GetTransactionsPaginationLoading extends GetTransactionsState {
  final List<TransactionModel> transactions;
  final bool hasMore;

  GetTransactionsPaginationLoading(this.transactions, this.hasMore);
}

class GetTransactionsSuccess extends GetTransactionsState {
  final List<TransactionModel> transactions;
  final bool hasMore;

  GetTransactionsSuccess(this.transactions, this.hasMore);
}

class GetTransactionsError extends GetTransactionsState {
  final String message;

  GetTransactionsError(this.message);
}
