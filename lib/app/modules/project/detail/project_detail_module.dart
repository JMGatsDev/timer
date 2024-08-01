import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:timer/app/modules/project/detail/project_detail_page.dart';

class ProjectDetailModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(ProjectDetailController.new);
    super.binds(i);
  }




  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context)  {return  ProjectDetailPage(
        controller: Modular.get()..setProject(r.args.data)
      );}
    );
    super.routes(r);
  }
}
