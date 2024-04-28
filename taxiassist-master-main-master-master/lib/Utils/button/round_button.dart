import 'package:flutter/material.dart';
import 'package:taxiassist/Utils/app_color/app_colors.dart';

class MyButton extends StatelessWidget {
  void Function()? ontap;
  final String text;
   MyButton({super.key, required this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,

      
      child: Container(
        width: 350,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.purpleColor,
          borderRadius: BorderRadius.circular(30),
          
        ),
        child: Center(
          child: Text(text,style: TextStyle(color: AppColors.whiteColor),) ,
        ),
      ),
    );
  }
}