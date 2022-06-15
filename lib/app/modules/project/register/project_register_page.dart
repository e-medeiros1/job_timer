import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/register/controller/project_register_controller.dart';
import 'package:validatorless/validatorless.dart';

// ignore: must_be_immutable
class ProjectRegisterPage extends StatefulWidget {
  ProjectRegisterController controller;

  ProjectRegisterPage({super.key, required this.controller});
//Formulário precisa ser statefulWidget
  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  //Adiciona a global Key e seta a Key no body
  final _formKey = GlobalKey<FormState>();
  //Adiciona os controllers e seta no formfield
  final _projectNameEC = TextEditingController();
  final _estimateEC = TextEditingController();

  //Adiciona o dispose para descartá-los
  @override
  void dispose() {
    _projectNameEC.dispose();
    _estimateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
//Adicionando o blocListener pois não é preciso rebuildar a tela
//Utilizando Asuka pra mostrar o erro
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      //Bloclistener precisa estar linkado com algum bloc, como não está
      //sendo utilizado nenhum provider, é preciso especificar
      bloc: widget.controller,
      listener: ((context, state) {
        switch (state) {
          //Observa o caso de sucesso e falha do enum PRStatus
          case ProjectRegisterStatus.success:
            //Em caso de sucesso, volta pra home
            Navigator.pop(context);
            break;
          case ProjectRegisterStatus.failure:
            AsukaSnackbar.alert('Erro ao salvar projeto').show();
            break;
          default:
            break;
        }
      }),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Criar novo projeto',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _projectNameEC,
                  decoration: const InputDecoration(
                    label: Text('Nome do projeto'),
                  ),
                  //Sempre adicionar uma validação
                  //Utiliza-se o package validatorless
                  validator: Validatorless.required('Nome obrigatório'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _estimateEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Estimativa de horas'),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('Estimativa obrigatória'),
                    Validatorless.number('Permitido somente números'),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: screenSize.width * 1,
                  height: 49,
                  child: ButtonWithLoader<ProjectRegisterController,
                      ProjectRegisterStatus>(
                    bloc: widget.controller,
                    selector: (state) => state == ProjectRegisterStatus.loading,
                    onPressed: () async {
                      //Para o validator funcionar, faça a checagem e guarde em uma
                      // variável, se for nulo, é falso
                      final formValid =
                          _formKey.currentState?.validate() ?? false;

                      if (formValid) {
                        //If valid, do something
                        final name = _projectNameEC.text;
                        //Transformando em inteiro
                        final estimate = double.parse(_estimateEC.text);

                        await widget.controller.register(name, estimate);
                      }
                    },
                    label: 'Salvar',
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
