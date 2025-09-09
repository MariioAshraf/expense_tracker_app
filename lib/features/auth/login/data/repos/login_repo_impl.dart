import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../constants.dart';
import '../../../../../core/errors/failure.dart';
import '../../../models/user_model.dart';
import '../models/login_input_body_model.dart';
import '../../domain/repos/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  @override
  Future<Either<Failure, String>> login(
      LoginInputBodyModel loginInputBodyModel) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: loginInputBodyModel.email,
              password: loginInputBodyModel.password);
      final uId = userCredential.user!.uid;
      return Right(uId);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFailure.fromFirebaseAuthException(e));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<UserModel> getUserData(String uId) async {
    final usersCollection =
        FirebaseFirestore.instance.collection(kUsersCollection);
    final docSnapshot = await usersCollection.doc(uId).get();
    final userModel = UserModel.fromJson(docSnapshot.data()!);
    return userModel;
  }
}
