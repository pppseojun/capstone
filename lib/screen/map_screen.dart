import 'dart:async';
import 'dart:math';

import 'package:capstone/screen/addGroup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class mapStartPoint extends StatefulWidget {
  const mapStartPoint({super.key});

  @override
  State<mapStartPoint> createState() => _mapStartPointState();
}

class _mapStartPointState extends State<mapStartPoint>
    with TickerProviderStateMixin {
  bool isMove = false;
  static final LatLng myLating = LatLng(37.275924, 127.132335);

  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 10),
  //   vsync: this,
  // )..repeat();

  static final CameraPosition _initialPosition =
      CameraPosition(target: myLating, zoom: 15);

  final _markers = <Marker>{};
  final _foodies = [
    {
      "name": "1",
      "latitude": 37.275924,
      "longitude": 127.132335,
    },
  ];

  @override
  void initState() {
    _markers.addAll(
      _foodies.map(
        (e) => Marker(
          markerId: MarkerId(e['name'] as String),
          infoWindow: InfoWindow(title: e['name'] as String),
          position: LatLng(
            e['latitude'] as double,
            e['longitude'] as double,
          ),
        ),
      ),
    );
    super.initState();
  }

  void _updatePosition(CameraPosition _position) async {
    var m = _markers.firstWhere(
      (p) => p.mapsId == MarkerId('1'),
    );
    _markers.remove(m);
    _markers.add(
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(_position.target.latitude, _position.target.longitude),
        draggable: true,
      ),
    );
    setState(() {});
    // print("위도");
    // print(_position.target.latitude);
    // print("경도");
    // print(_position.target.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '출발지',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          //구글 맵 실행하는 Section
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            markers: Set.from(_markers),
            zoomControlsEnabled: false,
            // myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onCameraMove: ((_position) => _updatePosition(_position)),
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
                label: Text("현재 위치로 출발지 설정"),
              ),
            ),
          ),
          Align(
            // alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(top: 0),
              child: Center(
                  child: Text(
                "현재 위치",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: Colors.blue),
              ),
              width: MediaQuery.of(context).size.width,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
