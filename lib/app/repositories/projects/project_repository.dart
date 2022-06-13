import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_task.dart';
import 'package:job_timer/app/entities/projetct_status.dart';

abstract class ProjectRepository {
  Future<void> register(Project project);
  Future<List<Project>> findMyStatus(ProjectStatus status);

  //Botão para salvar uma nova task
  Future<Project> findById(int projectId);
  Future<Project> addTask(int projectId, ProjectTask task);
  
  //Botão para finalizar task
  Future<void> finish(int projectId);
}
