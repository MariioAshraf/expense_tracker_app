import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

abstract class UseCase<rType, Param> {
  Future<Either<Failure, rType>> call([Param param]);
}

class NoParam {}
