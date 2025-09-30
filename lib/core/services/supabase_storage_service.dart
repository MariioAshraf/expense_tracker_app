import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:expense_tracker_app/core/errors/failure.dart';
import 'package:expense_tracker_app/core/services/storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../constants.dart';

class SupabaseStorageService implements StorageService {
  @override
  Future<Either<Failure, String>> uploadFile(File file, String path) async {
    try {
      final supabase = Supabase.instance.client;
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
      final String fullPath = '$kUsersCollection/$path/$fileName';
      await supabase.storage.from(kUsersCollection).upload(
            fullPath,
            file,
          );

      return right(
          supabase.storage.from(kUsersCollection).getPublicUrl(fullPath));
    } on Exception catch (e) {
      return left(SupabaseFailure(e.toString()));
    }
  }
}
