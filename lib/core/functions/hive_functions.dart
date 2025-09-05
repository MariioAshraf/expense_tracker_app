import 'package:hive/hive.dart';
import '../../constants.dart';
import '../../features/auth/models/user_model.dart';

class HiveFunctions {


  static Future<void> saveUser(UserModel user) async {
    final box = Hive.box<UserModel>(kUsersCollection);
    await box.put(kUsersCollection, user);
  }

  static Future<UserModel?> getUser() async {
    final box = Hive.box<UserModel>(kUsersCollection);
    return box.get(kUsersCollection);
  }

}
