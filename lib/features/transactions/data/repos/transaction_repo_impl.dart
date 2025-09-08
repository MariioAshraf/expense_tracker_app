import 'package:expense_tracker_app/features/transactions/data/repos/transactions_repo.dart';
import 'package:hive/hive.dart';
import '../../../../constants.dart';
import '../models/transaction_model.dart';
import 'dart:math' show min;

class TransactionRepoImpl implements TransactionsRepo {
  @override
  Future<void> saveTransactionLocally(TransactionModel transactionModel) async {
    var box = Hive.box<TransactionModel>(kTransactionsBox);
    await box.add(transactionModel);
    // box.clear();
    // debugPrint('Transaction added successfully ${box.values.last.toMap()}');
  }

  @override
  Future<List<TransactionModel>> getTransactions({
    String? typeFilter,
    String? dateFilter,
    required int page,
    int pageSize = 10,
  }) async {
    var box = Hive.box<TransactionModel>(kTransactionsBox);
    var all = box.values.toList();

    all.sort((a, b) => b.date.compareTo(a.date));

    if (typeFilter != null && typeFilter.isNotEmpty) {
      final f = typeFilter.toLowerCase();
      all = all.where((e) => e.type.toLowerCase() == f).toList();
    }

    if (dateFilter != null && dateFilter.isNotEmpty) {
      final now = DateTime.now();

      if (dateFilter == 'this_month') {
        final startOfMonth = DateTime(now.year, now.month, 1);
        final startOfNextMonth = DateTime(now.year, now.month + 1, 1);
        all = all
            .where((e) =>
                !e.date.isBefore(startOfMonth) &&
                e.date.isBefore(startOfNextMonth))
            .toList();
      } else if (dateFilter == 'last_7_days') {
        final todayStart = DateTime(now.year, now.month, now.day);
        final cutoff = todayStart.subtract(const Duration(days: 6));
        all = all.where((e) => !e.date.isBefore(cutoff)).toList();
      }
    }

    final total = all.length;
    final start = page * pageSize;

    if (start >= total) {
      return const [];
    }

    final end = min(start + pageSize, total);
    final result = all.sublist(start, end);

    return result;
  }

}
