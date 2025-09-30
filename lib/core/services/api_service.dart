// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import '../../../../constants.dart';
// import '../../../../core/errors/failure.dart';
//
// class ApiService {
//   final Dio _dio;
//
//   ApiService()
//       : _dio = Dio(BaseOptions(
//     baseUrl: "https://open.er-api.com/v6/",
//     connectTimeout: const Duration(seconds: 10),
//     receiveTimeout: const Duration(seconds: 10),
//   )) {
//     _dio.interceptors.add(
//       PrettyDioLogger(
//         requestHeader: true,
//         requestBody: true,
//         responseHeader: false,
//         responseBody: true,
//         error: true,
//         compact: true,
//         maxWidth: 90,
//       ),
//     );
//   }
//
//   Future<Response> getRequest(String endpoint) async {
//     return await _dio.get(endpoint);
//   }
// }
//
// class CurrencyRepo {
//   final ApiService _apiService = ApiService();
//
//   Future<Either<Failure, double>> convertToUsd(
//       double amount, String fromCurrency) async {
//     try {
//       final response = await _apiService.getRequest("latest/USD");
//
//       if (response.statusCode == 200) {
//         final data = response.data;
//         final rate = data[kConversionRate][fromCurrency.toUpperCase()];
//
//         if (rate != null) {
//           final usdAmount = amount * (1 / rate);
//           return Right(usdAmount);
//         } else {
//           return Left(Failure("Currency not found in API"));
//         }
//       } else {
//         return Left(Failure("Failed to fetch exchange rates"));
//       }
//     } on DioException catch (e) {
//       return Left(Failure(e.message ?? "Unexpected Dio Error"));
//     } catch (e) {
//       return Left(Failure(e.toString()));
//     }
//   }
// }
