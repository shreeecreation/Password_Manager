import 'package:hive/hive.dart';
part "task.g.dart";

@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  final String user;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String pass;
  @HiveField(3)
  final String cat;
  @HiveField(4)
  final String notes;
  Task(
      {required this.user,
      required this.name,
      required this.pass,
      required this.cat,
      required this.notes});
}
