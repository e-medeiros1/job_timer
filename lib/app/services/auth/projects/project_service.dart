import 'package:job_timer/app/entities/projetct_status.dart';
import 'package:job_timer/app/view_models/project_model.dart';

abstract class ProjectService {
  Future<void> register(ProjectModel projectModel);
  Future<List<ProjectModel>> findMyStatus(ProjectStatus status);
}