import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/core/exceptions/failure.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_task.dart';
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

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    final connection = await _database.openConnection();
    final projects = await findById(projectId);

    projects.tasks.add(task);
    await connection.writeTxn((isar) => projects.tasks.save());
    return projects;
  }

  @override
  Future<Project> findById(int projectId) async {
    final connection = await _database.openConnection();
    final projects = await connection.projects.get(projectId);

    if (projects == null) {
      throw Failure(message: 'Projeto não encontrado');
    }
    return projects;
  }

  @override
  Future<void> finish(int projectId) async {
    //Abrindo DB
    try {
      final connection = await _database.openConnection();
      //Chamando instância de project
      final projects = await findById(projectId);
      //Alterando status do projeto
      projects.status = ProjectStatus.finalizado;
      //Salvando alterações no DB
      await connection.writeTxn(
          (isar) => connection.projects.put(projects, saveLinks: true));
    } on IsarError catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      throw Failure(message: 'Erro ao finalizar projeto');
    }
  }
}
