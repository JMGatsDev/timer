import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timer/app/core/database/database.dart';
import 'package:timer/app/entities/project.dart';
import 'package:timer/app/entities/project_status.dart';
import 'package:timer/app/modules/home/widgets/Header_project_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Drawer(
        child: SafeArea(
          child: ListTile(
            title: Text('Sair'),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('Projetos'),
              expandedHeight: 100,
              toolbarHeight: 100,
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: HeaderProjectMenu(),
              pinned: true,
            ),
          ],
        ),
      ),
    );
  }
}
