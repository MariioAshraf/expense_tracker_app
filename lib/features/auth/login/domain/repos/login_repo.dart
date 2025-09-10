import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../models/user_model.dart';
import '../../data/models/login_input_body_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, String>> login(
      LoginInputBodyModel loginInputBodyModel);

  Future<UserModel> getUserData(String uId);
}
