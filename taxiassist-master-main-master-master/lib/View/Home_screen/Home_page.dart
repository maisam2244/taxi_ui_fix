import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taxiassist/Utils/app_color/app_colors.dart';
import 'package:taxiassist/View/Splash_screen/splash_screen.dart';


class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.blackColor,
        title: Text("Your name",style: TextStyle(color: AppColors.whiteColor),),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.blackColor,
        child: DrawerHeader(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            ListTile(
                            onTap: () async {
                              await GoogleSignIn().signOut();

                              await FirebaseAuth.instance.signOut();

                              _auth.signOut();

                              Get.to(() => const Splash_Screen());
                            },
                            leading: const Icon(
                              Icons.logout,
                              size: 40,
                            ),
                            title: Text(
                              "Logout".tr,
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColors.whiteColor,
                            ),
                          )
            
          ],
        ),),
        
      
    ));
  }
}
 // Text("Your name",style: TextStyle(color: AppColors.whiteColor),),
            // Text("Your email",style:TextStyle(color: AppColors.whiteColor) ,),