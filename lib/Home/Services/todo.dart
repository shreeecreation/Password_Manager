import 'package:bloc_pattern/Home/Services/task.dart';
import 'package:hive/hive.dart';

class TodoService {
  static late Box<Task> tasks;

  Future<void> init() async {
    // Hive.deleteBoxFromDisk("task");
    Hive.registerAdapter(TaskAdapter());
    tasks = await Hive.openBox<Task>("task");
    // await tasks.clear();
    print("jadu");
  }

  List<Task> getTasks(final String username) {
    final task = tasks.values.where((element) => element.user == username);
    return task.toList();
  }

  void addTask(final String username, final String name, final String password,
      final String notes, final String cat) {
    tasks.add(Task(
        user: username, name: name, pass: password, notes: notes, cat: cat));
    print(tasks.keys);
  }

  static void removeTask(final int index) async {
    await tasks.delete(index);
  }

  static Future<void> update(
      final String username,
      final String name,
      final String password,
      final String notes,
      final String cat,
      int index) async {
    tasks.put(
        index,
        Task(
            user: username,
            name: name,
            pass: password,
            notes: notes,
            cat: cat));

    // tasks.putAt(tasks.keys, value)

    print(username);
  }
}
