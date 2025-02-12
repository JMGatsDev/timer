import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/core/database/database.dart';
import 'package:timer/app/core/database/database_impl.dart';
import 'package:timer/app/modules/home/home_module.dart';
import 'package:timer/app/modules/login/login_module.dart';
import 'package:timer/app/modules/project/project_module.dart';
import 'package:timer/app/modules/splash/splash_page.dart';
import 'package:timer/app/repositories/projects/project_repository.dart';
import 'package:timer/app/repositories/projects/project_repository_impl.dart';
import 'package:timer/app/services/auth/auth_service.dart';
import 'package:timer/app/services/auth/auth_service_impl.dart';
import 'package:timer/app/services/projects/project_service.dart';
import 'package:timer/app/services/projects/project_service_impl.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    [
      i.addLazySingleton<AuthService>(AuthServiceImpl.new),
      i.addLazySingleton<Database>(DatabaseImpl.new),
      i.addLazySingleton<ProjectRepository>(ProjectRepositoryImpl.new),
      i.addLazySingleton<ProjectService>(ProjectServiceImpl.new)
    ];
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const SplashPage());
    r.module('/login', module: LoginModule());
    r.module('/home', module: HomeModule());
    r.module('/project', module: ProjectModule());
    super.routes(r);
  }
}
