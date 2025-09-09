import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/models/totals_model.dart';
import '../../../data/models/transaction_model.dart';
import '../../../domain/entities/filters.dart';
import '../../../domain/use_cases/get_transaction_use_case.dart';

part 'get_transactions_event.dart';

part 'get_transactions_state.dart';

class GetTransactionsBloc
    extends Bloc<GetTransactionsEvent, GetTransactionsState> {
  final GetTransactionsUseCase getTransactionsUseCase;
  List<TransactionModel> allTransactions = [];
  final TextEditingController dateController = TextEditingController();

  GetTransactionsBloc(this.getTransactionsUseCase)
      : super(GetTransactionsInitial()) {
    on<LoadTransactionsEvent>(_onLoadTransactions);
  }

  Future<void> _onLoadTransactions(
    LoadTransactionsEvent event,
    Emitter<GetTransactionsState> emit,
  ) async {
    if (allTransactions.isEmpty || event.page == 0) {
      emit(GetTransactionsLoading());
      allTransactions.clear();
    } else {
      emit(GetTransactionsPaginationLoading(allTransactions, true));
    }

    final result = await getTransactionsUseCase.call(
      GetTransactionsParams(
        page: event.page,
        pageSize: event.pageSize,
        typeFilter: event.typeFilter,
        dateFilter: event.dateFilter,
      ),
    );

    result.fold(
      (failure) => emit(GetTransactionsError(failure.message)),
      (transactions) {
        for (final tx in transactions) {
          final exists = allTransactions.any((t) => t.id == tx.id);
          if (!exists) {
            allTransactions.add(tx);
          }
        }
        final hasMore = transactions.length == event.pageSize;
        debugPrint('hasMore $hasMore');
        _calculateTotals(allTransactions, emit);
        emit(GetTransactionsSuccess(
          List.unmodifiable(allTransactions),
          hasMore,
        ));
      },
    );
  }

  _calculateTotals(
      List<TransactionModel> transactions, Emitter<GetTransactionsState> emit) {
    double totalIncome = 0;
    double totalExpense = 0;

    for (final tx in transactions) {
      if (tx.type == TransactionTypeFilter.income) {
        totalIncome += tx.amount;
      } else if (tx.type == TransactionTypeFilter.expense) {
        totalExpense += tx.amount;
      }
    }
    final totals = Totals(
      income: totalIncome,
      expense: totalExpense,
      balance: totalIncome - totalExpense,
    );
    emit(CalculateTotalsSuccess(totals));
  }
}
