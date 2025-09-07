import '../models/transaction_model.dart';

abstract class TransactionsRepo {
  Future<void> saveTransactionLocally(TransactionModel transactionModel);
}
