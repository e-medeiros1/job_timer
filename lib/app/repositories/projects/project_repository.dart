import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/projetct_status.dart';

abstract class ProjectRepository {
  Future<void> register(Project project);
  Future<List<Project>> findMyStatus(ProjectStatus status);
}
