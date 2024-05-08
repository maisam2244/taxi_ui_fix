import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiassist/Utils/app_color/app_colors.dart';
import 'package:taxiassist/View/Home_screen/Customer_location_numbers/customer_detailed_location_page.dart';

class CustomerLocationNumbers extends StatelessWidget {
  CustomerLocationNumbers({
    Key? key,
  }) : super(key: key);
  final user_appointments =
      FirebaseFirestore.instance.collection("customers_location_name").snapshots();
  // final accepted_appointments =
  //     FirebaseFirestore.instance.collection("Accepted_appoinments");

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    return Scaffold(
      backgroundColor: AppColors.liteblackColor,
      appBar: AppBar(
        title: Text(
          "Get your fare",
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.litepurplecolor,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: user_appointments,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Text("Loading");
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                       String info_driver_name = snapshot.data!.docs[index]["driver_name"];
                      String info_map_location_address = snapshot.data!.docs[index]["map_location_address"];
                      String num_of_passengers = snapshot.data!.docs[index]["num_of_passengers"];
                      String info_driver_pic_url = user!.photoURL.toString();
                      String Latitude = snapshot.data!.docs[index]["latitude"];
                      String Longitude = snapshot.data!.docs[index]["longitude"];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => LocationPage(driver_name: info_driver_name.toString(), location_adrress: info_map_location_address, number_of_passengers: num_of_passengers, Latitude: Latitude, Longitude: Longitude,));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Container(
                            height: 120,
                            width: 390,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.blackColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          NetworkImage(info_driver_pic_url),
                                    ),
                                    Text(
                                      info_driver_name,
                                      style: TextStyle(color: AppColors.whiteColor, fontSize: 17, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                        
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded( // Wrap this Column with Expanded
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center, // Align text to start
                                    children: [
                                     
                                      Text(
                                        info_map_location_address,
                                        style: TextStyle(color: AppColors.whiteColor, fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Passengers: " + num_of_passengers,
                                          style: TextStyle(color: AppColors.whiteColor, fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
