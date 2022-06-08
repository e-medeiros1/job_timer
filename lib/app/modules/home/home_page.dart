import 'package:flutter/material.dart';
import 'package:job_timer/app/modules/home/widgets/header_project_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              delegate: HeaderProjectMenu(),
              pinned: true,
            )
          ],
        ),
      ),
    );
  }
}
