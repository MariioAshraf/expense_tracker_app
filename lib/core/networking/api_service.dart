import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  final String _baseUrl = 'https://open.er-api.com/v6/';

  ApiService(this._dio);

  Future<Map<String, dynamic>> convertToUSD(String endPoint) async {
    var response = await _dio.get('$_baseUrl$endPoint',
        options: Options(headers: {'Accept': 'application/json'}));
    return response.data;
  }
}
