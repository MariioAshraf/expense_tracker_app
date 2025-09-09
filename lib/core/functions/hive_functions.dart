import 'package:expense_tracker_app/features/auth/models/user_model.dart';
import 'package:hive/hive.dart';
import '../../constants.dart';

class HiveFunctions {
  // static Future<void> setBalance({double balance = 0}) async {
  //   final box = Hive.box<String>(kUserBalanceBox);
  //   await box.put(kUserBalance, balance.toString());
  // }

  static saveUserModel(UserModel user) {
    final box = Hive.box<UserModel>(kUsersBox);
    box.put(kUserId, user);
  }

  static Future<UserModel?> getUserModel() async {
    final box = Hive.box<UserModel>(kUsersBox);
    return box.get(kUserId);
  }

  // we can make transaction type as enum
  static Future<void> updateUserTotalExpensesAndIncome(
      String type, double convertedAmount) async {
    final box = Hive.box<UserModel>(kUsersBox);
    final user = box.get(kUserId);
    if (type.toLowerCase() == 'income') {
      user!.totalIncome += convertedAmount;
    }
    if (type.toLowerCase() == 'expense') {
      user!.totalExpense += convertedAmount;
    }

    await user!.save();
  }
}
