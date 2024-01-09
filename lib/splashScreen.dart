// ignore_for_file: file_names

import 'package:calculate/calculatorScreen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void switchToSignInPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const CalculateScreen()));
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), switchToSignInPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/logo.png",
            width: 260,
            height: 220,
          )
        ]),
      ),
    );
  }
}
