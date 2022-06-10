import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/projetct_status.dart';
import 'package:job_timer/app/repositories/projects/project_repository.dart';
import 'package:job_timer/app/view_models/project_model.dart';

import './project_service.dart';

class ProjectServiceImpl implements ProjectService {
  final ProjectRepository _projectRepository;

  ProjectServiceImpl({required ProjectRepository projectRepository})
      : _projectRepository = projectRepository;

  @override
  Future<void> register(ProjectModel projectModel) async {
    //Transforma projectModel em um Project
    //ProjectModel --> Entidade
    //Utilizando CascadeNotation
    final project = Project()
      // project.id = projectModel.id
      ..id = projectModel.id
      ..name = projectModel.name
      ..estimate = projectModel.estimate
      ..status = projectModel.status;

    await _projectRepository.register(project);
  }

  @override
  Future<List<ProjectModel>> findMyStatus(ProjectStatus status) async {
    final projects = await _projectRepository.findMyStatus(status);

    return projects.map(ProjectModel.fromEntity).toList();
  }
  //Adiciona dependências dentro do modular(App_Module)
}
