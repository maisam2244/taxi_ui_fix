import "package:flutter/material.dart";
import "package:taxiassist/Utils/button/drawer_button.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(child: Container(
        child: Column(
          children: [
            SizedBox(height:             MediaQuery.of(context).size.height*0.1,),
            MyDrawerButton(ontap: (){}, text1: "Train Schedules")
            
            
                    ]
        ),
      )),
    );
  }
}