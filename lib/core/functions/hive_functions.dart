import 'package:hive/hive.dart';
import '../../constants.dart';

class HiveFunctions {
  static Future<void> saveUserId(String userId) async {
    final box = Hive.box<String>(kUsersBox);
    await box.put(kUserId, userId);
  }

  static Future<String?> getUserId() async {
    final box = Hive.box<String>(kUsersBox);
    return box.get(kUserId);
  }

  static Future<void> openBox() async {
    await Hive.openBox<String>(kUsersBox);
  }
}
