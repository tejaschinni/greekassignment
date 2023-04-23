import 'package:greekassignment/models/userModel.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data {
  static Box<User> getData() => Hive.box<User>("data");
}
