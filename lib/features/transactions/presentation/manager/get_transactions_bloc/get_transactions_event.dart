part of 'get_transactions_bloc.dart';

@immutable
sealed class GetTransactionsEvent {}
class LoadTransactionsEvent extends GetTransactionsEvent {
  final int page;
  final int pageSize;
  final String? typeFilter;
  final String? dateFilter;

  LoadTransactionsEvent({
    required this.page,
    required this.pageSize,
    this.typeFilter,
    this.dateFilter,
  });
}
