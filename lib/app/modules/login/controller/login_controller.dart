import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/services/auth/auth_services.dart';

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController({required AuthServices authServices})
      : _authServices = authServices,
        super(const LoginState.initial());
  final AuthServices _authServices;

  Future<void> signIn() async {
    //Altera o status de initial para loading
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await _authServices.signIn();
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Erro ao realizar login',
      ));
    }
    // Future.delayed(const Duration(seconds: 2), () {
    //   emit(state.copyWith(status: LoginStatus.initial));
    // });
  }
}
