import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/app/core/ui/button_with_loader.dart';
import 'package:timer/app/modules/project/task/controller/task_controller.dart';
import 'package:validatorless/validatorless.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.controller});
  final TaskController controller;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _nameEC = TextEditingController();
  final _durationEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameEC.dispose();
    _durationEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state == TaskStatus.success) {
          Navigator.pop(context);
          AsukaSnackbar.success('Task cirada com sucesso').show();
        } else if (state == TaskStatus.failure) {
          AsukaSnackbar.alert('Erro ao salvar task').show();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Criar nova task',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Nome da task'),
                  ),
                  validator: Validatorless.required('Nome obrigatorio'),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _durationEC,
                  decoration: const InputDecoration(
                    label: Text('Duração'),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('Duração Obrigatoria'),
                    Validatorless.number('Somente números')
                  ]),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                SizedBox(
                  height: screenSize.height * 0.06,
                  width: screenSize.width,
                  child: ButtonWithLoader<TaskController, TaskStatus>(
                    bloc: widget.controller,
                    selector: (state) => state == TaskStatus.loading,
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        final duration = int.parse(_durationEC.text);
                        widget.controller.register(_nameEC.text, duration);
                      }
                    },
                    label: 'Salvar',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
