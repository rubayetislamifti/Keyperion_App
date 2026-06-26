import 'package:flutter/material.dart';
import 'package:keyperion/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState(){
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(microseconds: 1500));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
    });
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
              'assets/images/logo.png',
                width: 200,
                height: 60,
                ),
              const SizedBox(height: 24),

              const CircularProgressIndicator(
                color: Color(0xFF000000),
                strokeWidth: 3,
              )
            ],
          ),
        ),
      ),
    );
  }
}
