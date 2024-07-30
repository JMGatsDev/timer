import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/modules/home/home_page.dart';
import 'package:timer/app/modules/home/widgets/controller/home_controller.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(HomeController.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => HomePage(
        controller: Modular.get()..loadProjects(),
      ),
    );

    super.routes(r);
  }
}
