import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:timer/app/entities/project_status.dart';
import 'package:timer/app/modules/home/widgets/controller/home_controller.dart';

class HeaderProjectMenu extends SliverPersistentHeaderDelegate {
  HeaderProjectMenu({
    required this.controller,
  });
  final HomeController controller;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: constraints.maxWidth * 0.5,
                child: DropdownButtonFormField<ProjectStatus>(
                  value: ProjectStatus.emAndamento,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      isCollapsed: true),
                  items: ProjectStatus.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.label),
                          ))
                      .toList(),
                  onChanged: (status) {
                    if (status != null) {
                      controller.filter(status);
                    }
                  },
                ),
              ),
              SizedBox(
                width: constraints.maxWidth * 0.4,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    await Modular.to.pushNamed('/project/register');
                    controller.loadProjects();
                  },
                  label: const Text('Novo Projeto'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
