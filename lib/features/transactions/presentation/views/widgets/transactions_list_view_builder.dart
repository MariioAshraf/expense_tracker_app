import 'package:expense_tracker_app/features/transactions/data/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/features/transactions/presentation/manager/get_transactions_bloc/get_transactions_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsListViewBuilder extends StatelessWidget {
  const TransactionsListViewBuilder({
    super.key,
    required ScrollController scrollController,
    required this.transactions,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        if (index < transactions.length) {
          final tx = transactions[index];
          return ListTile(
            title: Text("${tx.categoryName} - ${tx.amount} ${tx.currency}"),
            subtitle: Text(tx.date.toString()),
          );
        } else {
          final currentState = context.read<GetTransactionsBloc>().state;
          if (currentState is GetTransactionsPaginationLoading) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return const SizedBox.shrink();
          }
        }
      },
    );
  }
}