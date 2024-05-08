import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taxiassist/Controller/Google_map/google_map.dart';
import 'package:taxiassist/Utils/app_color/app_colors.dart';
import 'package:taxiassist/Utils/button/drawer_button.dart';
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
SizedBox(height: MediaQuery.sizeOf(context).height*0.1,),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),
            Text("maisam123@gmail.com",style: TextStyle(color: AppColors.whiteColor),),

            SizedBox(height: MediaQuery.sizeOf(context).height*0.08,),
            MyDrawerButton(ontap: (){
              Get.to(() => const GoogleMaps());

            }, text1: "Share information"),
            MyDrawerButton(ontap: (){}, text1: "Train Schedules"),
            MyDrawerButton(ontap: (){}, text1: "Get fare"),
            MyDrawerButton(ontap: (){}, text1: "Contact us"),
            MyDrawerButton(ontap: ()async{
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
               _auth.signOut();
               Get.to(() => const Splash_Screen());


            }, text1: "Log out"),


            
            
            
         
            
          ],
        ),),
        
      
    ));
  }
}
 // Text("Your name",style: TextStyle(color: AppColors.whiteColor),),
            // Text("Your email",style:TextStyle(color: AppColors.whiteColor) ,),