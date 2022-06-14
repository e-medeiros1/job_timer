import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/entities/projetct_status.dart';
import 'package:job_timer/app/services/auth/auth_services.dart';
import 'package:job_timer/app/services/auth/projects/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final AuthServices _authServices;
  final ProjectService _projectService;
  //Imutabilidade
  //Ninguém tem acesso ao project service sem ser a controller
  HomeController(
      {required AuthServices authServices,
      required ProjectService projectService})
      : _authServices = authServices,
        _projectService = projectService,
        super(
          HomeState.initial(),
        );

  Future<void> loadProjects() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      final projects = await _projectService.findMyStatus(state.projectFilter);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } on Exception catch (e, s) {
      log('Erro ao buscar os projetos', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  //Criando filtro
  Future<void> filter(ProjectStatus status) async {
    //Emitindo um novo status
    emit(state.copyWith(status: HomeStatus.loading, projects: []));
    //Buscando projetos
    final projects = await _projectService.findMyStatus(status);
    //Emitindo um novo status
    emit(state.copyWith(
        status: HomeStatus.complete,
        projects: projects,
        projectFilter: status));
  }

  void updateList() => (state.projectFilter);

//Método para sair
  Future<void> logout() async{
    await _authServices.signOut();
  }
}
