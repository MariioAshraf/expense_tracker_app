import 'dart:io';
import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

abstract class StorageService {
  Future<Either<Failure, String>> uploadFile(File file, String path);
}
