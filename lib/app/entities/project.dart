import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/converters/project_status_converter.dart';
import 'package:job_timer/app/entities/project_task.dart';
import 'package:job_timer/app/entities/projetct_status.dart';

part 'project.g.dart';

@Collection()
class Project {
  @Id()
  int? id;

  late String name;

  @ProjectStatusConverter()
  late ProjectStatus status;
  
  final tasks = IsarLinks<ProjectTask>();
}
