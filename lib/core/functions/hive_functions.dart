import 'package:expense_tracker_app/features/auth/models/user_model.dart';
import 'package:hive/hive.dart';
import '../../constants.dart';

class HiveFunctions {
  static saveUserModel(UserModel user) {
    final box = Hive.box<UserModel>(kUsersBox);
    box.put(kUserId, user);
  }

  static Future<UserModel?> getUserModel() async {
    final box = Hive.box<UserModel>(kUsersBox);
    return box.get(kUserId);
  }
}
