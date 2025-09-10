part of 'add_transaction_bloc.dart';

@immutable
sealed class AddTransactionsState {}

final class AddTransactionInitial extends AddTransactionsState {}

final class AddTransactionSuccessState extends AddTransactionsState {}

final class AddTransactionErrorState extends AddTransactionsState {
  final String message;

  AddTransactionErrorState(this.message);
}

final class AddTransactionLoadingState extends AddTransactionsState {}

final class TransactionFilePickedSuccessState extends AddTransactionsState {
  final String filePath;

  TransactionFilePickedSuccessState(this.filePath);
}
