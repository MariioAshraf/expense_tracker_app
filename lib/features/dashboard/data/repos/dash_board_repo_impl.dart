import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_tracker_app/constants.dart';
import 'package:expense_tracker_app/core/services/store_service.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/functions/hive_functions.dart';
import '../../../../core/services/storage_service.dart';
import '../../../auth/models/user_model.dart';
import 'dash_board_repo.dart';

class DashBoardRepoImpl implements DashBoardRepo {
  final StorageService storageService;
  final StoreService storeService;
  @override
  late UserModel? user;

  DashBoardRepoImpl({
    required this.storageService,
    required this.storeService,
  });

  @override
  Future<Either<Failure, String>> changeUserProfileImage(
      File file, String userId) async {
    final result = await storageService.uploadFile(file, userId);

    return result.fold(
      left,
      (path) async {
        try {
          await FirebaseFirestore.instance
              .collection(kUsersCollection)
              .doc(userId)
              .update({kUserProfileImage: path});

          // storeService.addData(
          //   data: {kUserProfileImage: path},
          //   docId: userId,
          //   collectionName: kUsersCollection,
          // );

          return right(path);
        } on FirebaseException catch (e) {
          return left(Failure('Firestore error: ${e.message}'));
        } catch (e) {
          return left(Failure('Unexpected error: $e'));
        }
      },
    );
  }

  getUserData() async {
    user = await HiveFunctions.getUserModel();
  }
}
