import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/modules/project/register/project_register_module.dart';

class ProjectModule extends Module {



@override
  void routes(RouteManager r) {
    r.module('/register', module: ProjectRegisterModule());
    super.routes(r);
  }

}