import 'package:dartz/dartz.dart';
import 'package:expense_tracker_app/core/errors/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../data/models/transaction_model.dart';
import '../../data/repos/currency_repo.dart';
import '../../data/repos/transaction_repo_impl.dart';

class AddTransactionUseCase extends UseCase<void, TransactionModel> {
  final TransactionRepoImpl transactionRepo;
  final CurrencyRepo currencyRepo;

  AddTransactionUseCase(this.transactionRepo, this.currencyRepo);

  @override
  Future<Either<Failure, void>> call([TransactionModel? param]) async {
    final result = await currencyRepo.convertToUsd(
      param!.amount,
      param.currency,
    );
    return result.fold((failure) => Left(failure), (convertedAmount) async {
      final newTransaction = TransactionModel(
        amount: param.amount,
        currency: param.currency,
        convertedAmount: convertedAmount,
        date: param.date,
        type: param.type,
        categoryName: param.categoryName,
        categoryIcon: param.categoryIcon,
        receiptPath: param.receiptPath,
      );
      await transactionRepo.saveTransactionLocally(newTransaction);

      return Right(null);
    });
  }
}
