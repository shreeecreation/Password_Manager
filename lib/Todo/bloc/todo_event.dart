part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoInitialEvent extends TodoEvent {
  @override
  List<Object> get props => [];
}

class LoadTodosEvent extends TodoEvent {
  final String username;
  const LoadTodosEvent(this.username);
  @override
  List<Object> get props => [username];
}

class AddTodosEvent extends TodoEvent {
  final String password;
  final String title;
  final String notes;
  final String name;
  final String username;
  const AddTodosEvent(
      this.username, this.name, this.password, this.notes, this.title);
  @override
  List<Object> get props => [name, password, notes, title];
}
