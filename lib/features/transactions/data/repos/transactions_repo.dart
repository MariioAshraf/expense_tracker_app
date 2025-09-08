import '../models/transaction_model.dart';

abstract class TransactionsRepo {
  Future<void> saveTransactionLocally(TransactionModel transactionModel);

  Future<List<TransactionModel>> getTransactions({
    String? typeFilter,
    String? dateFilter,
    required int page,
    required int pageSize,
  });
}
