

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taxiassist/View/Home_screen/Home_page.dart';
import 'package:taxiassist/View/Home_screen/Login/login.dart';

class SplashScreenController  {
User? _user;

  void splashTimer() {
    if(_user != null){
      Timer(const Duration(seconds: 3), () { 
              Get.to(() => const Home_Page());

      });
    }
    else {
      Timer(const Duration(seconds: 3), () { 
              Get.to(() => const Login_Page());

      });
    }
  }
  
}