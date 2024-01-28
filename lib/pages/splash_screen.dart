import 'package:flutter/material.dart';
import 'package:samane_app/pages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? curveImage;
  Animation<double>? curveText;
  ColorTween? colorAnim;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    curveImage = CurvedAnimation(parent: controller!, curve: Curves.linear);
    curveText = CurvedAnimation(parent: controller!, curve: Curves.linear);
    colorAnim = ColorTween(begin: Colors.red, end: Colors.amber);
    controller!.forward();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(),
              FadeTransition(
                opacity: curveText!,
                child: Center(
                  child: Image.asset("assets/logo.png", height: 80.0),
                ),
              ),
              const Text(
                "Create by : HS Team",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
