import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:job_timer/app/core/database/database.dart';

import './auth_services.dart';

class AuthServicesImpl implements AuthServices {
  final Database _database;
  AuthServicesImpl({required Database database}) : _database = database;

  @override
  //Abrindo a tela para escolher email
  Future<void> signIn() async {
    final googleUser = await GoogleSignIn().signIn();

    //Obtendo os detalhes da conexão
    final googleAuth = await googleUser?.authentication;
    //Login pronto dentro do google, mas ainda não dentro do firebase

    //Criando credencial para login no firebase
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    //OBS: Login por rede social não precisa de cadastro
    //Passa a credencial para uma instancia do firebase
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    //Pode ser feito utilizando o cascade notation
    // await _database.openConnection()
    //   ..clearSync();
    final database = await _database.openConnection();
    await database.writeTxn((isar) => database.clear());

    //Se chamar apenas esse método, ele não apresenta a janela para login
    //Já loga novamente pois o googleSignIn salva o último email logado
    await FirebaseAuth.instance.signOut();
    GoogleSignIn().disconnect();
  }
}
