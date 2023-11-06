import 'package:capstone/firebase_options.dart';
import 'package:capstone/screen/addGroup_Screen.dart';
import 'package:capstone/screen/index_screen.dart';
import 'package:capstone/screen/main_screen.dart';
import 'package:capstone/screen/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'same same taxi',
      theme: ThemeData(primarySwatch: Colors.yellow),
      // home: LoginSignupScreen(),
      // home: mapScreen(),
      // home: AddGroupScreen(),
      home: mapStartPoint(),
    );
  }
}

/*import 'index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sstaxi',
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.red,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 100)),
                  Center(
                    child: Image(
                      image: AssetImage('images/mainImage.png'),
                      width: 170.0,
                      height: 190.0,
                    ),
                  ),
                  Form(
                      child: Theme(
                          data: ThemeData(
                              primaryColor: Colors.teal,
                              inputDecorationTheme: InputDecorationTheme(
                                  labelStyle: TextStyle(
                                      color: Colors.teal, fontSize: 20.0))),
                          child: Container(
                            padding:
                                EdgeInsets.fromLTRB(200.0, 40.0, 200.0, 40.0),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  autofocus: true,
                                  controller: controller,
                                  decoration:
                                      InputDecoration(labelText: 'Enter Id'),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                TextField(
                                  controller: controller2,
                                  decoration: InputDecoration(
                                      labelText: 'Enter password'),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                                ButtonTheme(
                                  minWidth: 100.0,
                                  height: 50.0,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 35.0,
                                    ),
                                    onPressed: () {
                                      if (controller.text == 'qkrtjwns' &&
                                          controller2.text == '1116') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        index()));
                                      } else if (controller.text ==
                                              'qkrtjwns' &&
                                          controller2.text != '1116') {
                                        showSnackBar2(context);
                                      } else if (controller.text !=
                                              'qkrtjwns' &&
                                          controller2.text == '1116') {
                                        showSnackBar3(context);
                                      } else {
                                        showSnackBar(context);
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          )))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void showSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      '로그인 정보를 확인하세요',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.yellow,
  ));
}

void showSnackBar2(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      '비밀번호 정보를 확인하세요',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.yellow,
  ));
}

void showSnackBar3(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      '아이디 정보를 확인하세요',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.yellow,
  ));
}*/
