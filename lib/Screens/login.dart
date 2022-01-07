// ignore_for_file: prefer_const_constructors, prefer_final_fields, unrelated_type_equality_checks, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:mysql1/mysql1.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sample1/Screens/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:sample1/Screens/settings0.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController u = TextEditingController();
  TextEditingController p = TextEditingController();

  Future login() async {
    const url = 'https://precision-air.herokuapp.com/';
    var response = await http.post(Uri.parse(url), body: {
      "u": u.text,
      "p": p.text,
    });
    var data = jsonDecode(response.body);
    var code = jsonDecode(response.body);

    if (data == "Success") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home(u.text)));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('u', u.text);
      // CircularProgressIndicator(
      //   color: HexColor("#415812"),
      //   strokeWidth: 1,
      // );
      // print(data);
    } else if (code == 'Empty') {
      Fluttertoast.showToast(
        msg: 'Username or Password is Empty',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Invalid Username and Password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    }
  }

  checking() {
    if (u == '' || p == '') {
      Fluttertoast.showToast(
        msg: 'Username or Password is Empty',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
      // print('m');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Image.asset('assets/logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        cursorColor: HexColor("#415812"),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor("#415812")),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor("#415812")),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          fillColor: HexColor("#415812"),
                          hoverColor: HexColor("#415812"),
                          focusColor: HexColor("#415812"),
                          hintText: 'Username',
                          prefixIcon: Icon(
                            Icons.person,
                            color: HexColor("#415812"),
                          ),
                        ),
                        maxLength: 13,
                        // keyboardType: TextInputType.phone,
                        controller: u,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        cursorColor: HexColor("#415812"),
                        obscureText: true,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor("#415812")),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor("#415812")),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          fillColor: HexColor("#415812"),
                          hoverColor: HexColor("#415812"),
                          focusColor: HexColor("#415812"),
                          hintText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock_sharp,
                            color: HexColor("#415812"),
                          ),
                        ),
                        maxLength: 13,
                        // keyboardType: TextInputType.phone,
                        controller: p,
                      ),
                    ),
                    SizedBox(
                      width: 365,
                      child: SizedBox(
                        height: 55,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  HexColor("#415812")),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  HexColor("#415812")),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: BorderSide(
                                          color: HexColor("#415812"))))),
                          onPressed: () async {
                            // await checking();
                            login();
                            // if(login()== true){
                            //   final SharedPreferences sharedPreferences =
                            //     await SharedPreferences.getInstance();
                            // sharedPreferences.setString('u', u.text);
                            // }
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0, top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.error),
                            Text(
                              'Forgot password ?',
                              style: TextStyle(
                                color: HexColor("#fdbe33"),
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Settings0()));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
