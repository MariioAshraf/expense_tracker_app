import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../auth/models/user_model.dart';

abstract class DashBoardRepo {
  Future<Either<Failure, String>> changeUserProfileImage(
      File file, String userId);

  late UserModel? user;
}
