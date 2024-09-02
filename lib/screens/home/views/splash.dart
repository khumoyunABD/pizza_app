import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   navigateToHomeScreen();
  //   super.initState();
  // }

  // void navigateToHomeScreen() async {
  //   Future.delayed(const Duration(seconds: 4), () {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => const HomeScreen(),
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Lottie.asset(
            "assets/animation/pizza-animation.json",
            repeat: true,
          ),
        ),
      ),
    );
  }
}
