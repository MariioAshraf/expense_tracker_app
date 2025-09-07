import 'package:expense_tracker_app/features/add_transaction/data/repos/transactions_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../../../../constants.dart';
import '../models/transaction_model.dart';

class TransactionRepoImpl implements TransactionsRepo {
  @override
  Future<void> saveTransactionLocally(TransactionModel transactionModel) async {
    var box = Hive.box<TransactionModel>(kTransactionsBox);
    // box.clear();
    // print('valuessssss ${box.values.first}');
    // await box.add(transactionModel);
    debugPrint('Transaction added successfully ${box.values.last.toMap()}');
  }
}
