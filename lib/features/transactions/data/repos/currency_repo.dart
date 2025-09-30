import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../constants.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/networking/api_service.dart';

class CurrencyRepo {
  final ApiService apiService;

  CurrencyRepo(this.apiService);

  Future<Either<Failure, double>> convertToUsd(
      double amount, String fromCurrency) async {
    try {
      final res = await apiService.convertToUSD("latest/USD");
      final rate = res[kConversionRate][fromCurrency.toUpperCase()];
      if (rate != null) {
        final usdAmount = amount * (1 / rate);
        return Right(usdAmount);
      } else {
        return Left(Failure("Currency not found in API"));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
