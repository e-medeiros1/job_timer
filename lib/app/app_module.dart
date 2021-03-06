import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/core/database/database_impl.dart';
import 'package:job_timer/app/modules/home/home_module.dart';
import 'package:job_timer/app/modules/login/login_module.dart';
import 'package:job_timer/app/modules/project/project_module.dart';
import 'package:job_timer/app/modules/splash/splash_page.dart';
import 'package:job_timer/app/repositories/projects/project_repository.dart';
import 'package:job_timer/app/repositories/projects/project_repository_impl.dart';
import 'package:job_timer/app/services/auth/auth_services.dart';
import 'package:job_timer/app/services/auth/auth_services_impl.dart';
import 'package:job_timer/app/services/auth/projects/project_service.dart';
import 'package:job_timer/app/services/auth/projects/project_service_impl.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        //Binding para ser utilizado em qualquer parte da aplicação
        Bind.lazySingleton<Database>((i) => DatabaseImpl()),
        Bind.lazySingleton<AuthServices>((i) => AuthServicesImpl(database: i())),
        Bind.lazySingleton<ProjectRepository>(
            (i) => ProjectRepositoryImpl(database: i())),
        Bind.lazySingleton<ProjectService>(
            (i) => ProjectServiceImpl(projectRepository: i()))
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: ((context, args) => const SplashPage()),
        ),
        ModuleRoute(
          '/login/',
          module: LoginModule(),
        ),
        ModuleRoute(
          '/home/',
          module: HomeModule(),
        ),
        ModuleRoute(
          '/project/',
          module: ProjectModule(),
        )
      ];
}
