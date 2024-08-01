import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/modules/project/task/controller/task_controller.dart';
import 'package:timer/app/modules/project/task/task_page.dart';

class TaskModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(TaskController.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => TaskPage(
        controller: Modular.get()..setProject(r.args.data),
      ),
    );
    super.routes(r);
  }
}
