import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/core/exceptions/failure.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/projetct_status.dart';

import './project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  //Recebe instancia de database
  final Database _database;

  ProjectRepositoryImpl({required Database database}) : _database = database;
  @override
  Future<void> register(Project project) async {
    try {
      final connection = await _database.openConnection();
      await connection.writeTxn((isar) {
        return isar.projects.put(project);
      });
    } on IsarError catch (e, s) {
      log('Erro ao cadastrar projeto', error: e, stackTrace: s);
      throw Failure(message: 'Erro ao cadastrar projeto');
    }
  }

  @override
  Future<List<Project>> findMyStatus(ProjectStatus status) async {
    final connection = await _database.openConnection();
    final projects =
        await connection.projects.filter().statusEqualTo(status).findAll();

    return projects;
  }
}
