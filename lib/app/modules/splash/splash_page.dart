import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('splash'),
      ),
      body: Column(
        children: [
          Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  label: Text(
                'texto aqui',
              )),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('oie'),
          ),
          // Icon(JobTimerIcons.angle_double_right)
        ],
      ),
    );
  }
}
