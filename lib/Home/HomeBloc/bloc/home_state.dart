part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  final String error;
  const HomeInitial({required this.error});
  @override
  List<Object> get props => [error];
}

class RegisterState extends HomeState {
  final String error;
  const RegisterState({required this.error});
  @override
  List<Object> get props => [error];
}

class SuccessLoginState extends HomeState {
  final String user;
  const SuccessLoginState(this.user);
  @override
  List<Object> get props => [user];
}

class RegisteringServiceState extends HomeState {
  @override
  List<Object> get props => [];
}

class EmptyFieldState extends HomeState {
  @override
  List<Object> get props => [];
}

class RecoverState extends HomeState {
  @override
  List<Object> get props => [];
}

class ForgotState extends HomeState {
  final String error;
  const ForgotState({required this.error});
  @override
  List<Object> get props => [error];
}

class SuccessForgotState extends HomeState {
  final String username;
  final String password;
  const SuccessForgotState(this.username, this.password);
  @override
  List<Object> get props => [username, password];
}
