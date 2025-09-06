import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class DashBoardRepo {
  Future<Either<Failure, String>> changeUserProfileImage(
      File file, String userId);
}
