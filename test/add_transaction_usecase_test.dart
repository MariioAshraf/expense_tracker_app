import 'package:expense_tracker_app/features/transactions/domain/entities/filters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:expense_tracker_app/features/transactions/data/models/transaction_model.dart';
import 'package:expense_tracker_app/features/transactions/domain/use_cases/add_transaction_use_case.dart';
import 'package:expense_tracker_app/features/transactions/data/repos/transaction_repo_impl.dart';
import 'package:expense_tracker_app/features/transactions/data/repos/currency_repo.dart';
import 'package:expense_tracker_app/core/errors/failure.dart';

// Mocks
class MockCurrencyRepo extends Mock implements CurrencyRepo {}

class MockTransactionRepo extends Mock implements TransactionRepoImpl {}

class FakeTransactionModel extends Fake implements TransactionModel {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeTransactionModel());
  });
  late MockCurrencyRepo mockCurrencyRepo;
  late MockTransactionRepo mockTransactionRepo;
  late AddTransactionUseCase useCase;

  setUp(() {
    mockCurrencyRepo = MockCurrencyRepo();
    mockTransactionRepo = MockTransactionRepo();
    useCase = AddTransactionUseCase(mockTransactionRepo, mockCurrencyRepo);
  });

  group('AddTransactionUseCase', () {
    final tTransaction = TransactionModel(
      amount: 100.0,
      currency: 'EGP',
      date: DateTime.now(),
      type: TransactionTypeFilter.expense,
      categoryName: 'food',
      categoryIcon: 0,
      receiptPath: null,
    );

    test(
        'returns Right(convertedAmount) and saves transaction when conversion succeeds',
        () async {
      // arrange
      when(() => mockCurrencyRepo.convertToUsd(any<double>(), any<String>()))
          .thenAnswer((_) async => Right(5.0));
      when(() => mockTransactionRepo.saveTransactionLocally(any()))
          .thenAnswer((_) async => Future.value());

      // act
      final result = await useCase.call(tTransaction);

      // assert
      result.fold(
        (l) => fail('Expected Right but got Left'),
        (r) => expect(r, 5.0),
      );

      verify(() => mockCurrencyRepo.convertToUsd(
          tTransaction.amount, tTransaction.currency)).called(1);
      verify(() => mockTransactionRepo.saveTransactionLocally(any())).called(1);
    });

    test('returns Left(failure) and does not save when conversion fails',
        () async {
      // arrange
      final failure = Failure('conversion failed');
      when(() => mockCurrencyRepo.convertToUsd(any<double>(), any<String>()))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await useCase.call(tTransaction);

      // assert
      result.fold(
        (l) => expect(l.message, 'conversion failed'),
        (r) => fail('Expected Left but got Right'),
      );

      verifyNever(() => mockTransactionRepo.saveTransactionLocally(any()));
    });
  });
}
