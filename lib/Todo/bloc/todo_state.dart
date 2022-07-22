part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodosLoadedState extends TodoState {
  final List<Task> tasks;
  final String username;
  const TodosLoadedState(this.tasks, this.username);
  @override
  List<Object> get props => [];
}

class AddTodo extends TodoState {
  @override
  List<Object> get props => [];
}

class EmptyState extends TodoState {
  // final String getTask;
  @override
  List<Object> get props => [];
}
