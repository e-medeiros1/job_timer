import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/ui/database/database.dart';
import 'package:job_timer/app/core/ui/database/database_impl.dart';
import 'package:job_timer/app/modules/home/home_module.dart';
import 'package:job_timer/app/modules/login/login_module.dart';
import 'package:job_timer/app/modules/splash/splash_page.dart';
import 'package:job_timer/app/services/auth/auth_services.dart';
import 'package:job_timer/app/services/auth/auth_services_impl.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        //Binding para ser utilizado em qualquer parte da aplicação
        Bind.lazySingleton<AuthServices>((i) => AuthServicesImpl()),
        Bind.lazySingleton<Database>((i) => DatabaseImpl()),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: ((context, args) => const SplashPage()),
        ),
        ModuleRoute(
          '/login',
          module: LoginModule(),
        ),
        ModuleRoute(
          '/home/',
          module: HomeModule(),
        )
      ];
}
