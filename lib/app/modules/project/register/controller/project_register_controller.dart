import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:job_timer/app/entities/projetct_status.dart';
import 'package:job_timer/app/services/auth/projects/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';
part 'project_register_state.dart';

class ProjectRegisterController extends Cubit<ProjectRegisterStatus> {
  ProjectService _projectService;
  ProjectRegisterController({required ProjectService projectService})
      : _projectService = projectService,
        super(
          ProjectRegisterStatus.initial,
        );

  Future<void> register(String name, int estimate) async {
    try {
      emit(ProjectRegisterStatus.loading);
      final project = ProjectModel(
        name: name,
        estimate: estimate,
        status: ProjectStatus.em_andamento,
        tasks: [],
      );
      await _projectService.register(project);
      await Future.delayed(const Duration(seconds: 1));
      //Depois do cadastro, deve-se informar que o cadastro foi concluido
      emit(ProjectRegisterStatus.success);
    } catch (e, s) {
      log('Falha ao salvar projeto', error: e, stackTrace: s);
      emit(ProjectRegisterStatus.failure);
    }
  }
}
