import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../data/models/transaction_model.dart';
import '../../data/repos/transaction_repo_impl.dart';

class GetTransactionsUseCase
    extends UseCase<List<TransactionModel>, GetTransactionsParams> {
  final TransactionRepoImpl repo;

  GetTransactionsUseCase(this.repo);

  @override
  Future<Either<Failure, List<TransactionModel>>> call(
      [GetTransactionsParams? params]) async {
    try {
      final transactionsList = await repo.getTransactions(
        page: params!.page,
        pageSize: params.pageSize,
        typeFilter: params.typeFilter,
        dateFilter: params.dateFilter,
      );
      return Right(transactionsList);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

class GetTransactionsParams {
  final int page;
  final int pageSize;
  final String? typeFilter;
  final String? dateFilter;

  GetTransactionsParams({
    required this.page,
    required this.pageSize,
    this.typeFilter,
    this.dateFilter,
  });
}
