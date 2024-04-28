import 'package:flutter/material.dart';
import 'package:taxiassist/Controller/splash_screen_controller.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final splashScreen = SplashScreenController();
    splashScreen.splashTimer();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(
        child:  Text("Paris Taxi App", style: TextStyle(fontSize: 30),),
        
      )
    );
  }
}