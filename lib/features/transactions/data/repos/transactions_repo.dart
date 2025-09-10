import '../../domain/entities/filters.dart';
import '../models/transaction_model.dart';

abstract class TransactionsRepo {
  Future<void> saveTransactionLocally(TransactionModel transactionModel);

  Future<List<TransactionModel>> getTransactions({
    TransactionTypeFilter? typeFilter,
    TransactionDateFilter? dateFilter,
    required int page,
    int pageSize = 10,
  });
}
