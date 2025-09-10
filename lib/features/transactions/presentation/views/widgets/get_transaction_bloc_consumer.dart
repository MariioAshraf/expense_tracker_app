import 'package:expense_tracker_app/core/utils/extensions.dart';
import 'package:expense_tracker_app/features/transactions/data/models/transaction_model.dart';
import 'package:expense_tracker_app/features/transactions/presentation/views/widgets/transactions_list_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/features/transactions/presentation/manager/get_transactions_bloc/get_transactions_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../../domain/entities/filters.dart';

class GetTransactionsBlocConsumer extends StatefulWidget {
  const GetTransactionsBlocConsumer({super.key});

  @override
  State<GetTransactionsBlocConsumer> createState() =>
      _GetTransactionsBlocConsumerState();
}

class _GetTransactionsBlocConsumerState
    extends State<GetTransactionsBlocConsumer> {
  final ScrollController _scrollController = ScrollController();
  late GetTransactionsBloc _getTransactionsBloc;
  int _page = 0;

  @override
  void initState() {
    _getTransactionsBloc = context.read<GetTransactionsBloc>();
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  TransactionDateFilter? _mapStringToDateFilter(String value) {
    switch (value) {
      case transactionDateFilterThisMonth:
        return TransactionDateFilter.thisMonth;
      case transactionDateFilterLast7Days:
        return TransactionDateFilter.last7Days;
      default:
        return null;
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final threshold = _scrollController.position.maxScrollExtent * 0.7;
    if (_scrollController.position.pixels >= threshold) {
      final state = _getTransactionsBloc.state;
      if (state is GetTransactionsSuccess && state.hasMore) {
        _page++;
        _getTransactionsBloc.add(
          LoadTransactionsEvent(
              page: _page,
              pageSize: 10,
              dateFilter: _mapStringToDateFilter(
                  _getTransactionsBloc.dateController.text)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final transactions = _getTransactionsBloc.allTransactions;
    return BlocConsumer<GetTransactionsBloc, GetTransactionsState>(
      listener: (context, state) {
        if (state is GetTransactionsError) {
          context.showSnackBar(message: state.message, color: Colors.red);
        }
      },
      builder: (context, state) {
        if (state is GetTransactionsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetTransactionsSuccess ||
            state is GetTransactionsPaginationLoading) {
          final transactions = state is GetTransactionsSuccess
              ? state.transactions
              : (state as GetTransactionsPaginationLoading).transactions;
          if (transactions.isEmpty) {
            return const Center(child: Text("No Transactions yet"));
          }

          return TransactionsListViewBuilder(
            scrollController: _scrollController,
            transactions: transactions,
          );
        }

        if (state is GetTransactionsError) {
          return Center(child: Text("Error: ${state.message}"));
        }

        return const SizedBox.shrink();
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}


