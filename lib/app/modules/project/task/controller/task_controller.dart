import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:job_timer/app/services/auth/projects/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';
import 'package:job_timer/app/view_models/project_task_model.dart';

part 'task_state.dart';

class TaskController extends Cubit<TaskStatus> {
//Não iremos precisar do ProjectModel na Task page, então não é necessário ele
//estar no TaskState, como só será usado na hora de salvar, pode adicioná-lo
// dentro do botão

//Como guardar uma informação dentro de um atributo que está dentro
// da controller?

//Adiciona como late & privado
//Ex. late final ProjectModel _projectModel;

//O errado é acessar o atributo fora da controller

  late final ProjectModel _projectModel;
  final ProjectService _projectService;

  TaskController({required ProjectService projectService})
      : _projectService = projectService,
        super(TaskStatus.initial);

  void setProject(ProjectModel projectModel) => _projectModel = projectModel;

  Future<void> register(String name, int duration) async {
    try {
      emit(TaskStatus.loading);
      final task = ProjectTaskModel(name: name, duration: duration);
      await _projectService.addTask(_projectModel.id!, task);
      await Future.delayed(Duration(seconds: 1));
      emit(TaskStatus.success);
    } catch (e, s) {
      log('Erro ao salvar task', error: e, stackTrace: s);
      emit(TaskStatus.failure);
    }
  }
}
