import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../data/models/register_input_model.dart';

abstract class SignUpRepo {
  Future<Either<Failure, String>> signUp(RegisterInputModel registerInputModel);

  Future<void> saveUserData(String name, String userId);
}
