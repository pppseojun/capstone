import 'dart:async';
import 'dart:math';

import 'package:capstone/screen/addGroup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class mapScreen extends StatefulWidget {
  const mapScreen({super.key});

  @override
  State<mapScreen> createState() => _mapScreenState();
}

class _mapScreenState extends State<mapScreen> {
  bool isMove = false;
  // static final LatLng myLating = LatLng(37.275546, 127.132144);
  // static final LatLng myLating = LatLng(37.4988064, 127.0274241);
  static final LatLng myLating = LatLng(37.275924, 127.132335);

  static final CameraPosition _initialPosition =
      CameraPosition(target: myLating, zoom: 15);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '메인 페이지',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onCameraMove: ((_position) => (_position)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AddGroupScreen();
                    }),
                  );
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.black,
                ),
                icon: Icon(Icons.add),
                label: Text("그룹추가하기"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
