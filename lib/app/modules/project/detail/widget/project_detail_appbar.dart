import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';
import 'package:job_timer/app/entities/projetct_status.dart';
import 'package:job_timer/app/modules/project/detail/widget/controller/project_detail_controller.dart';
import 'package:job_timer/app/view_models/project_model.dart';

class ProjectDetailAppbar extends SliverAppBar {
  ProjectDetailAppbar({
    required ProjectModel projectModel,
    super.key,
  }) : super(
          expandedHeight: 100,
          pinned: true,
          toolbarHeight: 60,
          centerTitle: true,
          title: Text(projectModel.name),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          flexibleSpace: Stack(children: [
            Align(
              alignment: const Alignment(0, 1.5),
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${projectModel.tasks.length} tasks'),
                            Visibility(
                              visible: projectModel.status !=
                                  ProjectStatus.finalizado,
                              replacement: Row(
                                children: const [
                                  Text('Projeto finalizado '),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: Icon(
                                      JobTimerIcons.ok_circled2,
                                      color: Color(0xFF014E90),
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              child: _NewTasks(projectModel: projectModel),
                            ),
                          ]),
                    ),
                  )),
            ),
          ]),
        );
}

class _NewTasks extends StatelessWidget {
  final ProjectModel projectModel;
  const _NewTasks({Key? key, required this.projectModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Modular.to.pushNamed('/project/task/', arguments: projectModel);
        Modular.get<ProjectDetailController>().updateProject();
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Text('Adicionar task'),
        ],
      ),
    );
  }
}
