import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:capstone/screen/addGroup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addGroup_Screen.dart';

class mapEndPoint extends StatefulWidget {
  const mapEndPoint({super.key});

  @override
  State<mapEndPoint> createState() => _mapEndPointState();
}

class _mapEndPointState extends State<mapEndPoint>
    with TickerProviderStateMixin {
  bool isMove = false;
  static final LatLng myLating = LatLng(37.275924, 127.132335);
  double currentLatitude = myLating.latitude;
  double currentLongitude = myLating.longitude;
  String currentAddress = "";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CameraPosition _initialPosition =
      CameraPosition(target: myLating, zoom: 17);

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
    _updateAddress(_initialPosition);
  }

  //현재 위치 주소 불러오는 함수
  Future<void> _updateAddress(CameraPosition _position) async {
    final apiKey = 'AIzaSyAK78IMsebRMkh3PJIv4oxdlwkyo9mOxRQ';
    final apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${_position.target.latitude},${_position.target.longitude}&key=$apiKey&language=ko';

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var firstResult = data['results'][0];
      String address = firstResult['formatted_address'];
      //앞에 대한민국 제거
      String address_result = address.replaceAll('대한민국', '');

      setState(() {
        currentLatitude = _position.target.latitude;
        currentLongitude = _position.target.longitude;
        currentAddress = address_result;
      });
    } else {
      // 주소 변환에 실패한 경우 에러 처리
      setState(() {
        currentAddress = "주소를 불러올 수 없습니다.";
      });
    }
  }

  Future<void> _updatePosition(CameraPosition _position) async {
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
    _updateAddress(_position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '목적지',
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
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onCameraMove: ((_position) => _updatePosition(_position)),
          ),

          //현재 위치 주소 text 구역
          Container(
            padding: EdgeInsets.only(bottom: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Center(
                    child: Text(
                  "현위치: $currentAddress",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: Colors.black.withAlpha(200)),
                  color: Color.fromARGB(200, 255, 195, 0),
                ),
                width: MediaQuery.of(context).size.width - 50,
                height: 90,
              ),
            ),
          ),

          //목적지 설정 버튼
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton.icon(
                onPressed: () async {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) {
                  //     return AddGroupScreen();
                  //   }),
                  // );
                  await _firestore
                      .collection('location')
                      .doc('endPoint')
                      .set({"ep": "$currentAddress"});

                  Navigator.pop(context);

                  setState(() {});

                  print("$currentAddress");
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.black,
                ),
                icon: Icon(Icons.add),
                label: Text("이곳을 목적지로 설정"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
