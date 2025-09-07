import 'package:expense_tracker_app/features/add_transaction/data/models/transaction_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/add_transaction_use_case.dart';

part 'add_transaction_event.dart';

part 'add_transaction_state.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  final transactionTypeController = TextEditingController();
  final categoryNameController = TextEditingController();
  final categoryIconController = TextEditingController();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final dateController = TextEditingController();
  final receiptController = TextEditingController();

  static AddTransactionBloc get(context) => BlocProvider.of(context);
  final AddTransactionUseCase addTransactionUseCase;

  AddTransactionBloc(this.addTransactionUseCase)
      : super(AddTransactionInitial()) {
    on<AddTransactionRequestedEvent>(_onAddNewTransaction);
    on<PickFileEvent>(_onPickFile);
  }

  Future<void> _onAddNewTransaction(
    AddTransactionRequestedEvent event,
    Emitter<AddTransactionState> emit,
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
    Emitter<AddTransactionState> emit,
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
  }
}
