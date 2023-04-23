import 'package:hive/hive.dart';
part 'userModel.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String profession;

  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.profession});
}
