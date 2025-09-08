import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/transaction_model.dart';
import '../../../domain/use_cases/add_transaction_use_case.dart';

part 'add_transaction_event.dart';

part 'add_transactions_state.dart';

class AddTransactionsBloc
    extends Bloc<AddTransactionsEvent, AddTransactionsState> {
  final transactionTypeController = TextEditingController();
  final categoryNameController = TextEditingController();
  final categoryIconController = TextEditingController();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final dateController = TextEditingController();
  final receiptController = TextEditingController();

  static AddTransactionsBloc get(context) => BlocProvider.of(context);
  final AddTransactionUseCase addTransactionUseCase;

  AddTransactionsBloc(this.addTransactionUseCase)
      : super(AddTransactionInitial()) {
    on<AddTransactionRequestedEvent>(_onAddNewTransaction);
    on<PickFileEvent>(_onPickFile);
  }

  Future<void> _onAddNewTransaction(
    AddTransactionRequestedEvent event,
    Emitter<AddTransactionsState> emit,
  ) async {
    emit(AddTransactionLoadingState());
    TransactionModel transactionModel = TransactionModel(
      amount: event.amount,
      currency: event.currency,
      date: event.date,
      type: event.type,
      receiptPath: event.receiptPath,
      categoryName: event.categoryName,
      categoryIcon: event.categoryIcon,
    );
    final result = await addTransactionUseCase.call(transactionModel);
    result.fold((failure) => emit(AddTransactionErrorState(failure.message)),
        (_) => emit(AddTransactionSuccessState()));
  }

  Future<void> _onPickFile(
    PickFileEvent event,
    Emitter<AddTransactionsState> emit,
  ) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      receiptController.text = result.files.single.path!;
      emit(TransactionFilePickedSuccessState(result.files.single.path!));
    }
  }

  disposeControllers() {
    dateController.dispose();
    amountController.dispose();
    categoryNameController.dispose();
    categoryIconController.dispose();
    transactionTypeController.dispose();
    receiptController.dispose();
    currencyController.dispose();
  }
}
