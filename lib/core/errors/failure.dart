import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Failure {
  final String message;

  const Failure(this.message);
}

class SupabaseFailure extends Failure {
  SupabaseFailure(super.message);
}

class FirebaseAuthFailure extends Failure {
  FirebaseAuthFailure(super.message);

  factory FirebaseAuthFailure.fromFirebaseAuthException(
      FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return FirebaseAuthFailure('The password provided is too weak.');
      case 'invalid-credential':
        return FirebaseAuthFailure('invalid credential.');
      case 'email-already-in-use':
        return FirebaseAuthFailure('email already in use.');
      case 'wrong-password':
        return FirebaseAuthFailure('Wrong password provided.');
      case 'user-not-found':
        return FirebaseAuthFailure('user not found.');
      default:
        return FirebaseAuthFailure('Authentication error.');
    }
  }
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Sent timeout Timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout Timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromDioResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');

      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') != null) {
          return ServerFailure('Connection error with Api');
        }
        return ServerFailure('UnExpected Error, please try again!');
    }
  }

  factory ServerFailure.fromDioResponse(int statusCode, dynamic response) {
    return ServerFailure(response['error-type']);
  }
}
