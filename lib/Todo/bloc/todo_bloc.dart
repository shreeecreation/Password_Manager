import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../Home/Services/task.dart';
import '../../Home/Services/todo.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoService _todoService;
  TodoBloc(this._todoService) : super(TodoInitial()) {
    on<LoadTodosEvent>((event, emit) {
      final todos = _todoService.getTasks(event.username);
      if (todos.isEmpty) {
        emit(EmptyState());
      } else {
        print("donw");
        emit(TodosLoadedState(todos, event.username));
      }
    });
    on<AddTodosEvent>((event, emit) {
      emit(AddTodo());
      _todoService.addTask(
          event.username, event.name, event.password, event.notes, event.title);
      final todos = _todoService.getTasks(event.username);

      emit(TodosLoadedState(todos, event.username));
    });
  }
}
