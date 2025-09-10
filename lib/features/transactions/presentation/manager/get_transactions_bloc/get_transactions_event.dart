part of 'get_transactions_bloc.dart';

@immutable
sealed class GetTransactionsEvent {}
class LoadTransactionsEvent extends GetTransactionsEvent {
  final int page;
  final int pageSize;
  final TransactionTypeFilter? typeFilter;
  final TransactionDateFilter? dateFilter;

  LoadTransactionsEvent({
    required this.page,
    required this.pageSize,
    this.typeFilter,
    this.dateFilter,
  });
}
