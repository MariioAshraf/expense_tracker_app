import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel extends HiveObject{
  @HiveField(0)
  late final String name;

  @HiveField(1)
  String? uId;

  @HiveField(2)
  String? profileImageUrl;

  @HiveField(3)
  String? coverImageUrl;

  @HiveField(4)
  double totalExpense;

  @HiveField(5)
  double totalIncome;

  UserModel({
    required this.name,
    this.uId,
    this.profileImageUrl = '',
    this.coverImageUrl = '',
    this.totalExpense = 0.0,
    this.totalIncome = 0.0,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        uId = json['uId'] as String?,
        profileImageUrl = json['profileImage'] as String?,
        coverImageUrl = json['coverImage'] as String?,
        totalExpense = (json['totalExpense'] ?? 0.0).toDouble(),
        totalIncome = (json['totalIncome'] ?? 0.0).toDouble();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'profileImage': profileImageUrl,
      'coverImage': coverImageUrl,
      'totalExpense': totalExpense,
      'totalIncome': totalIncome,
    };
  }
}
