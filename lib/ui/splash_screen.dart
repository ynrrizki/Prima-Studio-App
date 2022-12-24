import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prima_studio/ui/widgets/prima_studio.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  );

  @override
  void initState() {
    Timer(
      const Duration(milliseconds: 1800),
      () {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/menu', (route) => false);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/auth-login',
            (route) => false,
          );
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // listenWhen: (previous, current) => previous.authUser != current.authUser,
    // listener: (context, state) => print('Splash screen Auth Listener!'),
    return FadeTransition(
      opacity: _animation,
      child: const Scaffold(
        // backgroundColor: Colors.white,
        body: Center(
          child: PrimaStudio(fontSize: 27),
        ),
      ),
    );
  }
}
