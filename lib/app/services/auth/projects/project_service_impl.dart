import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_task.dart';
import 'package:job_timer/app/entities/projetct_status.dart';
import 'package:job_timer/app/repositories/projects/project_repository.dart';
import 'package:job_timer/app/view_models/project_model.dart';
import 'package:job_timer/app/view_models/project_task_model.dart';

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

  @override
  Future<ProjectModel> addTask(int projectId, ProjectTaskModel task) async {
    final projectTask = ProjectTask()
      ..name = task.name
      ..duration = task.duration;
    final projects = await _projectRepository.addTask(projectId, projectTask);

    return ProjectModel.fromEntity(projects);
  }

  @override
  Future<ProjectModel> findById(int projectId) async {
    final projects = await _projectRepository.findById(projectId);

    return ProjectModel.fromEntity(projects);
  }

  @override
  Future<void> finish(int projectId) => _projectRepository.finish(projectId);

}
