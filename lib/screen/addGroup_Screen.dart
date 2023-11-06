import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({super.key});

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  int? selectedPeople;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
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
              Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '출발지',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: '어디서 출발할까요?',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.blue),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '목적지',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: '목적지가 어디인가요?',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.blue),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
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
                  Text(
                    '1명',
                    style: TextStyle(fontSize: 20),
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
            ],
          ),
        ),
      ),
    );
  }
}
