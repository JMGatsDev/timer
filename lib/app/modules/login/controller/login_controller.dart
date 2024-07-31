import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/services/auth/auth_service.dart';

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthService _authService;

  LoginController()
      : _authService = Modular.get<AuthService>(),
        super(const LoginState.initial());

  Future<void> singIn() async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await _authService.singIn();
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: LoginStatus.failure,
            errorMassage: 'Erro ao realizar login'),
      );
    }
  }
}
