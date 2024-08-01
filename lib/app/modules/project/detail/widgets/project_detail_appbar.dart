import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/entities/project_status.dart';
import 'package:timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:timer/app/view_model/project_model.dart';

class ProjectDetailAppbar extends SliverAppBar {
  ProjectDetailAppbar({required ProjectModel projectModel, super.key})
      : super(
          pinned: true,
          title: Text(projectModel.name),
          expandedHeight: 100,
          toolbarHeight: 100,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          flexibleSpace: Stack(
            children: [
              Align(
                alignment: const Alignment(0, 1.6),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${projectModel.tasks.length} Tasks'),
                          Visibility(
                              visible: projectModel.status !=
                                  ProjectStatus.finalizado,
                              replacement: const Text('Projeto finalizado'),
                              child: _NewTasks(
                                projectModel: projectModel,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
}

class _NewTasks extends StatelessWidget {
  const _NewTasks({required this.projectModel});
  final ProjectModel projectModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
       await Modular.to.pushNamed('/project/task', arguments: projectModel);
       Modular.get<ProjectDetailController>().updateProject();
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Text('Adicionar Task')
        ],
      ),
    );
  }
}
