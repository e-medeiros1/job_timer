import 'package:flutter/material.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';
import 'package:job_timer/app/view_models/project_model.dart';

//Responsável pelo marcador de duração dos projetos na home page
class ProjectTile extends StatelessWidget {
  ProjectTile({Key? key, required this.projectModel}) : super(key: key);

  final ProjectModel projectModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 90),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 4),
      ),
      child: Column(children: [
        _ProjectName(projectModel: projectModel),
        Expanded(child: _ProjectProgress(projectModel: projectModel))
      ]),
    );
  }
}

class _ProjectName extends StatelessWidget {
  final ProjectModel projectModel;

  const _ProjectName({Key? key, required this.projectModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(projectModel.name),
          Icon(
            JobTimerIcons.angle_double_right,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _ProjectProgress extends StatelessWidget {
  final ProjectModel projectModel;

  const _ProjectProgress({Key? key, required this.projectModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Cálculo de porcentagem para o gráfico
    final totalTasks = projectModel.tasks.fold<int>(
        0, (previousValue, tasks) => previousValue += tasks.duration);

    var percentage = 0.0;

    if (totalTasks > 0) {
      percentage = totalTasks / projectModel.estimate;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(children: [
        Expanded(
          child: LinearProgressIndicator(
            value: percentage,
            color: Colors.grey.shade400,
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text('${projectModel.estimate}h'),
        )
      ]),
    );
  }
}
