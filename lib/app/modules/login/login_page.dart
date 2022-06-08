import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/modules/login/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller;
  const LoginPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    //Adiciona o BlocListener para mostrar a mensagem de erro na tela caso
    //o status altere para failure
    return BlocListener<LoginController, LoginState>(
      bloc: controller,
      listenWhen: (previous, current) => previous.status != current.status,
      listener: ((context, state) {
        if (state.status == LoginStatus.failure) {
          final message = state.errorMessage ?? 'Erro ao realizar login';
          AsukaSnackbar.alert(message).show();
        }
      }),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF009289),
                Color(0xFF0167B2),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  scale: 0.8,
                ),
                SizedBox(height: screenSize.height * .15),
                SizedBox(
                  height: 49,
                  width: screenSize.width * .8,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.signIn();
                    },
                    style:
                        ElevatedButton.styleFrom(primary: Colors.grey.shade200),
                    child: Image.asset('assets/images/google.png'),
                  ),
                ),
                SizedBox(height: screenSize.height * .05),
                BlocSelector<LoginController, LoginState, bool>(
                  bloc: controller,
                  selector: (state) => state.status == LoginStatus.loading,
                  builder: (context, show) {
                    return Visibility(
                      visible: show,
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
