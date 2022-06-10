import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/modules/home/controller/home_controller.dart';
import 'package:job_timer/app/modules/home/widgets/header_project_menu.dart';
import 'package:job_timer/app/modules/home/widgets/project_tile.dart';
import 'package:job_timer/app/view_models/project_model.dart';

class HomePage extends StatelessWidget {
  HomeController controller;

  HomePage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      //Não esquecer de sinalizar o BloC
      bloc: controller,
      listener: ((context, state) {
        if (state.status == HomeStatus.failure) {
          AsukaSnackbar.alert('Erro ao carregar projetos');
        }
      }),
      child: Scaffold(
        drawer: const Drawer(
          child: SafeArea(
              child: ListTile(
            title: Text('Sair'),
          )),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Projetos'),
                centerTitle: true,
                toolbarHeight: 60,
                expandedHeight: 100,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15)),
                ),
              ),
              SliverPersistentHeader(
                delegate: HeaderProjectMenu(controller: controller),
                pinned: true,
              ),
              //BloC
              BlocSelector<HomeController, HomeState, bool>(
                  bloc: controller,
                  selector: (state) => state.status == HomeStatus.loading,
                  builder: (context, showLoading) {
                    return SliverVisibility(
                        visible: showLoading,
                        sliver: const SliverToBoxAdapter(
                            child: SizedBox(
                          height: 50,
                          child: Center(
                              child: CircularProgressIndicator.adaptive()),
                        )));
                  }),
              BlocSelector<HomeController, HomeState, List<ProjectModel>>(
                bloc: controller,
                selector: ((state) {
                  return state.projects;
                }),
                builder: (context, projects) {
                  return SliverList(
                    delegate: SliverChildListDelegate(projects
                        .map((project) => ProjectTile(projectModel: project))
                        .toList()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
