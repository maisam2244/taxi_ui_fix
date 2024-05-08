// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiassist/Controller/Google_map/google_map.dart';
import 'package:taxiassist/Model/User_Model/usermodel.dart';
import 'package:taxiassist/View/Home_screen/Customer_location_numbers/customer_location_numbers.dart';
import 'package:taxiassist/View/Home_screen/Home_page.dart';
import 'package:taxiassist/View/Home_screen/Login/login.dart';
import 'package:taxiassist/View/Home_screen/Register/phone.dart';
import 'package:taxiassist/View/Home_screen/Register/register.dart';
import 'package:taxiassist/View/Splash_screen/splash_screen.dart';
import 'package:taxiassist/firebase_options.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  final UserModel? userModel;
  final User? firebaseUser;
  final UserModel? targetUser;

  const MyApp({Key? key, this.userModel, this.firebaseUser, this.targetUser}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomerLocationNumbers(),
      // home: Phone(
      //   userModel: widget.userModel ?? UserModel(), 
      //   firebaseUser: this.widget.firebaseUser ?? FirebaseAuth.instance.currentUser!,

      //   targetUser: widget.targetUser ?? UserModel(),
      // )
    );
  }
}