part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends HomeEvent {
  final String username;
  //jadu

  final String password;
  const LoginEvent(this.username, this.password);
  @override
  List<Object> get props => [username, password];
}

class RegisteringServicesEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class RegisterEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class AccountCreateuser extends HomeEvent {
  final String username;
  final String password;
  final String recovery;
  final BuildContext context;
  const AccountCreateuser(
      this.username, this.password, this.recovery, this.context);
  @override
  List<Object> get props => [username, password];
}

class EmptyFieldEvent extends HomeEvent {
  final String username;
  final String password;
  const EmptyFieldEvent(this.username, this.password);
  @override
  List<Object> get props => [username, password];
}

class RecoverEvent extends HomeEvent {
  final String username;
  final String password;
  const RecoverEvent(this.username, this.password);
  @override
  List<Object> get props => [username, password];
}

class ForgotEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class SuccessRecover extends HomeEvent {
  @override
  List<Object> get props => [];
}
