import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // Modular.get<AuthService>().singOut();
    super.initState();
    //identificar se o usuario está logado ou não 
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
         Modular.to.navigate('/login');
        } else {
          Modular.to.navigate('/home');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(
              0XFF0092B9,
            ),
            Color(
              0XFF0167B2,
            ),
          ],
        ),
      ),
      child: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    ));
  }
}
