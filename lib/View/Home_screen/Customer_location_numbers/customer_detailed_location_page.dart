// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:taxiassist/Utils/app_color/app_colors.dart';
import 'package:taxiassist/Utils/button/map_button.dart';
import 'package:taxiassist/Utils/button/round_button.dart';
import 'package:taxiassist/Utils/textfield/text_fields.dart';
import 'package:taxiassist/View/Home_screen/Customer_location_numbers/customer_location_numbers.dart';

class LocationPage extends StatefulWidget {
  String driver_name;
  String location_adrress;
  String number_of_passengers;
  String Latitude;
  String Longitude ;

  LocationPage({
    Key? key,
    required this.driver_name,
    required this.location_adrress,
    required this.number_of_passengers,
    required this.Latitude,
    required this. Longitude,
  }) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
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
  
  TextEditingController num_of_passengers = TextEditingController();
  TextEditingController location_name = TextEditingController();
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
        child: MapButton(
          text: "Driver Details",
          ontap: () async {
            getUserCurrentLocation().then((value) async {
              print("My Location".tr);
              print(dateTime);
              print(
                  "${value.latitude} ${value.longitude}");
              _marker.add(Marker(
                  markerId: const MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: InfoWindow(title: "My Location".tr)));
              
        
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
                        child: Text("Driver's Details",style: TextStyle(color: Colors.white,fontSize: 20),),
                      ),

                      Text(widget.driver_name,style: TextStyle(color: Colors.white,fontSize: 20)),
                      Text(widget.location_adrress,style: TextStyle(color: Colors.white,fontSize: 20)),
                      Text(widget.number_of_passengers,style: TextStyle(color: Colors.white,fontSize: 20)),
                     
                     
                      
                    ],
                  ),
                ),
                
              )
            );
            
          },
          
          
        ),
      ),
      
    );
  }
}
