import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../constants.dart';
import '../../../../../core/errors/failure.dart';
import '../../../models/user_model.dart';
import '../../domain/repos/sign_up_repo.dart';
import '../models/register_input_model.dart';

class SignUpRepoImpl implements SignUpRepo {
  @override
  Future<Either<Failure, String>> signUp(
      RegisterInputModel registerInputModel) async {
    try {
      final userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: registerInputModel.email,
              password: registerInputModel.password);
      final uId = userCredentials.user!.uid;
      return Right(uId);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFailure.fromFirebaseAuthException(e));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  // this method not in right place as clean code, but for now it is here
  @override
  Future<void> saveUserData(String name, String userId) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(kUsersCollection);
    final userModel = UserModel(
      name: name,
      uId: userId,
    );
    await usersCollection.doc(userId).set(userModel.toJson());
  }
}
