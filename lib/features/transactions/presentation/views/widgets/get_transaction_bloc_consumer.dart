import 'package:expense_tracker_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/features/transactions/presentation/manager/get_transactions_bloc/get_transactions_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetTransactionsBlocConsumer extends StatefulWidget {
  const GetTransactionsBlocConsumer({super.key});

  @override
  State<GetTransactionsBlocConsumer> createState() =>
      _GetTransactionsBlocConsumerState();
}

class _GetTransactionsBlocConsumerState
    extends State<GetTransactionsBlocConsumer> {
  final ScrollController _scrollController = ScrollController();
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final threshold = _scrollController.position.maxScrollExtent * 0.7;
    if (_scrollController.position.pixels >= threshold) {
      final state = context.read<GetTransactionsBloc>().state;
      if (state is GetTransactionsSuccess && state.hasMore) {
        _page++;
        context.read<GetTransactionsBloc>().add(
              LoadTransactionsEvent(page: _page, pageSize: 10),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final transactions = context.read<GetTransactionsBloc>().allTransactions;
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

          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              if (index < transactions.length) {
                final tx = transactions[index];
                return ListTile(
                  title:
                      Text("${tx.categoryName} - ${tx.amount} ${tx.currency}"),
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
