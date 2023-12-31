import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:capstone/screen/map_EndPoint_screen.dart';
import 'package:capstone/screen/map_StartPoint_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/retry.dart';

class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({super.key});

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  int? selectedPeople;
  var StartPoint = '';
  var EndPoint = '';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void _StartPointAddress() async {
    var result =
        await _firestore.collection('location').doc('startPoint').get();
    print("${result.get('sp')}");
  }

  void _EndPointAddress() async {
    var result = await _firestore.collection('location').doc('endPoint').get();
    print("${result.get('ep')}");
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('그룹추가 페이지'),
        actions: [
          IconButton(
              onPressed: () {
                _authentication.signOut();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.exit_to_app_sharp,
                color: Colors.white,
              ))
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  'images/hitchhiker.png',
                  width: 200,
                ),
              ),
              //출발지 Text
              GestureDetector(
                onTap: () {
                  print("출발지");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const mapStartPoint()));
                },
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.add_location,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "출발지: $StartPoint",
                        ),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.blue),
                  ),
                  width: MediaQuery.of(context).size.width - 30,
                  height: 60,
                ),
              ),

              SizedBox(
                height: 10,
              ),

              //도착지 Text
              GestureDetector(
                onTap: () {
                  print("도착지");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const mapEndPoint()));
                },
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.add_location,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "목적지: $EndPoint",
                        ),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.blue),
                  ),
                  width: MediaQuery.of(context).size.width - 30,
                  height: 60,
                ),
              ),
              // Container(
              //   padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       labelText: '출발지',
              //       labelStyle: TextStyle(color: Colors.black),
              //       hintText: '어디서 출발할까요?',
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //         borderSide: BorderSide(width: 1, color: Colors.blue),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //         borderSide: BorderSide(width: 1, color: Colors.blue),
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //       ),
              //     ),
              //     keyboardType: TextInputType.text,
              //   ),
              // ),
              // Container(
              //   padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       labelText: '목적지',
              //       labelStyle: TextStyle(color: Colors.black),
              //       hintText: '목적지가 어디인가요?',
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //         borderSide: BorderSide(width: 1, color: Colors.blue),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //         borderSide: BorderSide(width: 1, color: Colors.blue),
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //       ),
              //     ),
              //     keyboardType: TextInputType.text,
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<int>(
                    value: 1,
                    groupValue: selectedPeople,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPeople = value;
                      });
                    },
                  ),
                  Container(
                    child: Text(
                      '1명',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Radio<int>(
                    value: 2,
                    groupValue: selectedPeople,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPeople = value;
                      });
                    },
                  ),
                  Text(
                    '2명',
                    style: TextStyle(fontSize: 20),
                  ),
                  Radio<int>(
                    value: 3,
                    groupValue: selectedPeople,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPeople = value;
                      });
                    },
                  ),
                  Text(
                    '3명',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Text('예상 소요시간:'),
              Text('예상 비용:'),
              Text('부담 비용:'),
              ElevatedButton(
                  onPressed: () async {
                    var StartResult = await _firestore
                        .collection('location')
                        .doc('startPoint')
                        .get();

                    var EndResult = await _firestore
                        .collection('location')
                        .doc('endPoint')
                        .get();

                    print("${StartResult.get('sp')}");
                    print("${EndResult.get('ep')}");

                    setState(() {
                      StartPoint = StartResult.get('sp');
                      EndPoint = EndResult.get('ep');
                    });
                  },
                  child: Text('데이터 불러오기'))
            ],
          ),
        ),
      ),
    );
  }
}
