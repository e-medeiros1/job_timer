import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/task/controller/task_controller.dart';
import 'package:validatorless/validatorless.dart';

class TaskPage extends StatefulWidget {
  final TaskController controller;

  const TaskPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  //Quando se tem controladores, não se pode usar statelessW
  //pois é preciso usar o dispose

  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _durationEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _durationEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state == TaskStatus.success) {
          Navigator.pop(context);
        } else if (state == TaskStatus.failure) {
          AsukaSnackbar.alert('Erro ao salvar Task').show();
        }
      },
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
                controller: _nameEC,
                decoration: const InputDecoration(
                  label: Text('Nome da task'),
                ),
                validator: Validatorless.required('Nome obrigatório'),
                //Sempre adicionar uma validação
                //Utiliza-se o package validatorless
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _durationEC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Duração da task'),
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('Duração obrigatória'),
                  Validatorless.number('Permitido somente números'),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: screenSize.width * 1,
                height: 49,
                //LoaderButton
                child: ButtonWithLoader<TaskController, TaskStatus>(
                    bloc: widget.controller,
                    selector: (state) => state == TaskStatus.loading,
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;

                      if (formValid) {
                        final duration = int.parse(_durationEC.text);
                        widget.controller.register(_nameEC.text, duration); 
                      }
                    },
                    label: 'Salvar'),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
