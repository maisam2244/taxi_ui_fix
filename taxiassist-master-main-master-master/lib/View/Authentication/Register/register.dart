import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:taxiassist/Model/User_Model/usermodel.dart';
import 'package:taxiassist/Utils/app_color/app_colors.dart';
import 'package:taxiassist/Utils/button/round_button.dart';
import 'package:taxiassist/Utils/textfield/text_fields.dart';
import 'package:taxiassist/View/Authentication/GoogleAuth/auth_service.dart';
import 'package:taxiassist/View/Authentication/Login/login.dart';

class  Register_Page extends StatelessWidget {
  const  Register_Page({super.key});

  @override
  Widget build(BuildContext context) {
    // TextEditingController emailController = TextEditingController();
    // TextEditingController passwordContoller = TextEditingController();
    // TextEditingController confirmPasswordContoller = TextEditingController();
    return  Scaffold(
      backgroundColor: AppColors.blackColor,
      body:  SafeArea(
          child: Center(
            child: Column(
              children: [

                SizedBox(height: MediaQuery.of(context).size.height*0.1,),

                Text("Infos taxi App",style: TextStyle(color: Colors.yellow,fontSize: 30, fontWeight: FontWeight.bold),),
                
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),


                  MyButton(
                  ontap: () {
                    return AuthServiceUserRegister(
                                  userModel: UserModel(),
                                  firebaseUser:
                                      FirebaseAuth.instance.currentUser)
                              .signInWithGoogle();
                  },
                  text: "Sign up with Google"
                ),

                SizedBox(height: MediaQuery.of(context).size.height*0.05,),

                GestureDetector(
                onTap: () {
                  Get.to(() => Login_Page());
                },
                child: Text("Already have an account? Login Now",
                style: TextStyle(color: AppColors.whiteColor, fontSize: 14),),
              ),

                // SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                // Text("Register User",style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold),),
                // SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                // MyTextField(hintText: "abc@xyz.com", labelText: "Email", controller: emailController),
                // SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                // MyTextField(hintText: "password", labelText: "Password", controller: passwordContoller),
                // SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                // MyTextField(hintText: "confirm password", labelText: "Confirm Password", controller: emailController),
                // SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                // MyButton(ontap: (){}, text: "Register"),
                // SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                // TextButton(onPressed: (){
                //   Get.to(() => Login_Page());
                // }, child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text("Already a member? ",style: TextStyle(color: AppColors.whiteColor),),
                //     SizedBox(width: MediaQuery.of(context).size.width*0.01 ,)
                //     ,Text("Sign in",style: TextStyle(color: AppColors.purpleColor),)
                  ],
                )
              )
            )
          );                    
  }
}