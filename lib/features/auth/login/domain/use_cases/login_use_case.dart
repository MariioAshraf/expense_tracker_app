import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../../../models/user_model.dart';
import '../../data/models/login_input_body_model.dart';
import '../repos/login_repo.dart';

class LoginUseCase extends UseCase<UserModel, LoginInputBodyModel> {
  final LoginRepo loginRepo;

  LoginUseCase(this.loginRepo);

  @override
  Future<Either<Failure, UserModel>> call([LoginInputBodyModel? param]) async {
    var result = await loginRepo.login(param!);
    return result.fold((failure) => Left(failure), (uId) async {
      final UserModel userModel = await loginRepo.getUserData(uId);
      return Right(userModel);
    });
  }
}
