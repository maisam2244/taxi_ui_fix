import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerLocationNumbers extends StatelessWidget {
  final String name;
  CustomerLocationNumbers({
    Key? key, required this.name
  }) : super(key: key);
  final user_appointments =
      FirebaseFirestore.instance.collection("customers_location_name").doc("Asad").collection("details").snapshots();
  // final accepted_appointments =
  //     FirebaseFirestore.instance.collection("Accepted_appoinments");

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text("Get your fare!",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          const SizedBox(
            height: 15,
          ),
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
                      return Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(snapshot.data!.docs[index]['driver_name']),
                                Text(snapshot.data!.docs[index]['date_time']),
                                Text(snapshot.data!.docs[index]['map_location_address']),
                                Text(snapshot.data!.docs[index]['num_of_passengers']),
                              ],
                            )),
                      );
                    },
                  ),
                );
              })
        ],
      )),
    );
  }
}
