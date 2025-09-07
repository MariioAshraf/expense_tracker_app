part of 'add_transaction_bloc.dart';

@immutable
sealed class AddTransactionState {}

final class AddTransactionInitial extends AddTransactionState {}

final class AddTransactionSuccessState extends AddTransactionState {}

final class AddTransactionErrorState extends AddTransactionState {
  final String message;

  AddTransactionErrorState(this.message);
}

final class AddTransactionLoadingState extends AddTransactionState {}

final class TransactionFilePickedSuccessState extends AddTransactionState {
  final String filePath;

  TransactionFilePickedSuccessState(this.filePath);
}
