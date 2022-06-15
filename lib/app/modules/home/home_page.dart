import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/modules/home/controller/home_controller.dart';
import 'package:job_timer/app/modules/home/widgets/header_project_menu.dart';
import 'package:job_timer/app/modules/home/widgets/project_tile.dart';
import 'package:job_timer/app/view_models/project_model.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomeController controller;

  HomePage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = FirebaseAuth.instance.currentUser;
    String? name = userData!.displayName;
    String? email = userData.email;
    String? photo = userData.photoURL;

    return BlocListener<HomeController, HomeState>(
      //Não esquecer de sinalizar o BloC
      bloc: controller,
      listener: ((context, state) {
        if (state.status == HomeStatus.failure) {
          AsukaSnackbar.alert('Erro ao carregar projetos');
        }
      }),
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: SafeArea(
              child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 16,
                      color: Colors.black45,
                      offset: Offset(0, 13),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFF009289),
                      Color(0xFF0167B2),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15)),
                ),
                width: double.infinity,
                height: 260,
                // color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(photo!, scale: 0.7),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Bem vindo, ',
                            style: TextStyle(fontSize: 19, color: Colors.white),
                          ),
                          Text(
                            name!,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      email!,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                onTap: () => controller.logout(),
                title: Text(
                  'Sair',
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.logout),
              ),
            ],
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
