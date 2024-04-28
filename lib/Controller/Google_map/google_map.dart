import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiassist/Utils/app_color/app_colors.dart';
import 'package:taxiassist/Utils/button/round_button.dart';
import 'package:taxiassist/Utils/textfield/text_fields.dart';


class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(24.8846, 67.1754),
    zoom: 16,
  );
  final List<Marker> _marker = [];
  final List<Marker> _list = [
    Marker(
        markerId: const MarkerId("1"),
        position: const LatLng(24.8846, 70.1754),
        infoWindow: InfoWindow(title: "Current Location".tr))
  ];
  String stAddress = '';
  String Latitude = " ";
  String Longitude = " ";  
  TextEditingController num_of_passengers = TextEditingController();
  TextEditingController location_name = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection("customers_location_name");
  var dateTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {});
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: kGooglePlex,
          markers: Set<Marker>.of(_marker),
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 60,
          width: 130,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(0))
          ),
          child: TextButton(
            onPressed: () async {
              getUserCurrentLocation().then((value) async {
                print("My Location".tr);
                print(dateTime);
                print(
                    "${value.latitude} ${value.longitude}");
                _marker.add(Marker(
                    markerId: const MarkerId("2"),
                    position: LatLng(value.latitude, value.longitude),
                    infoWindow: InfoWindow(title: "My Location".tr)));
                Latitude = value.latitude.toString();
                Longitude = value.longitude.toString();
          
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    value.latitude, value.longitude);
                stAddress = "${placemarks.reversed.last.country} ${placemarks.reversed.last.locality} ${placemarks.reversed.last.street}";
                CameraPosition cameraPosition = CameraPosition(
                    zoom: 16,
                    target: LatLng(
                      value.latitude,
                      value.longitude,
                    ));
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(cameraPosition));
                setState(() {});
              });
              Get.bottomSheet(
                Container(
                  height: 800,
                  width: double.infinity,
                  color: AppColors.blackColor,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Share customer's details",style: TextStyle(color: Colors.white,fontSize: 20),),
                        ),
                        const SizedBox(height: 20,),
                        MyTextField(hintText: "John", labelText: "Your Name", controller: nameController),
                        MyTextField(hintText: "e.g 5", labelText: "Number of passengers", controller: num_of_passengers),
                        MyTextField(hintText: "Airport", labelText: "Location", controller: location_name),
                        const SizedBox(height: 20,),
                        MyButton(ontap: (){
                          var id = DateTime.now().microsecondsSinceEpoch.toString();
                          fireStore.doc(nameController.text).collection("details").add({
                            "id": id,
                            "driver_name": nameController.text,
                            "num_of_passengers": num_of_passengers.text,
                            "location_name": location_name.text,
                            "map_location_address" : stAddress,
                            "date_time" : dateTime.toString(),
                          });
                            Get.snackbar("Success", "Your information has been sent");
                         
                            
                         
                    
                        }, text: "SEND")
                      ],
                    ),
                  ),
                  
                )
              );
              
            },
            child: Center(child: Text("click here", style: TextStyle( color: AppColors.whiteColor, fontWeight: FontWeight.bold, fontSize: 18),)),
            
          ),
        ),
      ),
      
    );
  }
}
