import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './auth_services.dart';

class AuthServicesImpl implements AuthServices {
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
  Future<void> signoUT() async {
    //Se chamar apenas esse método, ele não apresenta a janela para login
    //Já loga novamente pois o googleSignIn salva o último email logado
    await FirebaseAuth.instance.signOut();
    GoogleSignIn().disconnect();
  }
}
