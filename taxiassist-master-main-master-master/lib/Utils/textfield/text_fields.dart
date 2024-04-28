import 'package:flutter/material.dart';
import 'package:taxiassist/Utils/app_color/app_colors.dart';


class MyTextField extends StatelessWidget {
  String? hintText;
  String? labelText;
  TextEditingController? controller;
   MyTextField({super.key, @required this.hintText, @required this.labelText, @required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
                    decoration: BoxDecoration(
                      
                      border: Border.all(color: AppColors.whiteColor,width: 2), // Adjusted border color
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: TextFormField(
                          controller: controller,
                          style: TextStyle(color: AppColors.whiteColor), // Adjusted text color
                          decoration: InputDecoration(
                            labelText: labelText,
                            labelStyle: TextStyle(color: AppColors.whiteColor), // Changed label to labelText
                            hintText: hintText, 
                            hintStyle: TextStyle(color: AppColors.whiteColor), // Changed hintText for clarity
                            border: InputBorder.none, // Removed default border
                          ),
                        ),
                      ),
                    ),
                  ),
    );
  }
}