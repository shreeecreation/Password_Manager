// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:bloc_pattern/Home/Services/authentication.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../Services/todo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final TodoService _service;
  HomeBloc(this._auth, this._service) : super(RegisteringServiceState()) {
    on<LoginEvent>((event, emit) async {
      final user = await _auth.authenticateUser(event.username, event.password);
      if (user != null) {
        emit(SuccessLoginState(user));
        emit(HomeInitial(error: ''));
      } else {
        emit(HomeInitial(error: "Username password doesn't exist !"));
      }
    });
    on<RegisteringServicesEvent>((event, emit) {
      _auth.init();
      _service.init();
      // _service.CheckEmpty();
      emit(const HomeInitial(error: ''));
    });
    on<AccountCreateuser>((event, emit) async {
      if (event.username == "" ||
          event.password == "" ||
          event.recovery == "") {
        emit(RegisterState(
            error: "Username,password,recovery cannot be Empty !"));
      } else {
        final result = await _auth.createUser(
            event.username, event.password, event.recovery, event.context);
        switch (result) {
          case userAccountCreationResult.success:
            emit(SuccessLoginState(event.username));
            emit(const RegisterState(error: ''));

            break;
          case userAccountCreationResult.already_exists:
            // ignore: todo
            // TODO: Handle this case.
            emit(RegisterState(error: "User Already Created !"));
            break;
          case userAccountCreationResult.failure:
            emit(RegisterState(error: "User Already Created !"));

            // ignore: todo
            // TODO: Handle this case.
            break;
        }
      }
    });
    on<RegisterEvent>((event, emit) {
      emit(RegisterState(error: ""));
    });
    on<RecoverEvent>((event, emit) async {
      final issuccess =
          await _auth.authenticateRecovery(event.username, event.password);
      switch (issuccess) {
        case LoginResult.failure:
          emit(ForgotState(error: "Username recovery incorrect"));
          break;
        case LoginResult.success:
          AuthenticationService.GetPassword(event.username);
          emit(SuccessForgotState(event.username,
              AuthenticationService.GetPassword(event.username)));
          break;
      }
      // emit(RecoverState(issuccess));
      print(issuccess);
    });
    on<ForgotEvent>((event, emit) {
      emit(ForgotState(error: ""));
    });
    // on<SuccessRecover>((event, emit) {
    //   SuccessForgotState();
    // });
  }
}
