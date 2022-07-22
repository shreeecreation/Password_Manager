import 'package:hive/hive.dart';
part "model.g.dart";

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final String recover;

  User({required this.username, required this.password, required this.recover});
}
