part of 'login_controller.dart';

//Status base para saber quando que devemos fazer alguma coisa na tela
enum LoginStatus { initial, loading, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorMessage;

  const LoginState._({required this.status, this.errorMessage});
  const LoginState.initial() : this._(status: LoginStatus.initial);

//Vai identificar onde/quando os atributos irão mudar
  @override
  List<Object?> get props => [status, errorMessage];

//Cópia da classe para o BloC
  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
