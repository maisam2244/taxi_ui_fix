import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiassist/Model/User_Model/usermodel.dart';
import 'package:taxiassist/View/Authentication/Register/register.dart';
import 'package:taxiassist/firebase_options.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final UserModel? userModel;
  final User? firebaseUser;
  const MyApp({Key? key, this.userModel, this.firebaseUser}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Register_Page()
    );
  }
}