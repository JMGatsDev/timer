import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/modules/login/controller/login_controller.dart';
import 'package:timer/app/modules/login/login_page.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(LoginController.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (context) => LoginPage(
              controller: Modular.get(),
            ));
    super.routes(r);
  }
}
