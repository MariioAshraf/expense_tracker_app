import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../constants.dart';
import '../../../../core/errors/failure.dart';

// i will do it with api service class with dio and dio pretty logger later
class CurrencyRepo {
  final _baseUrl = "https://open.er-api.com/v6/latest/USD";

  Future<Either<Failure, double>> convertToUsd(
      double amount, String fromCurrency) async {
    final res = await http.get(Uri.parse(_baseUrl));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final rate = data[kConversionRate][fromCurrency.toUpperCase()];
      if (rate != null) {
        final usdAmount = amount * (1 / rate);
        return Right(usdAmount);
      } else {
        return Left(Failure("Currency not found in API"));
      }
    } else {
      return Left(Failure("Failed to fetch exchange rates"));
    }
  }
}
