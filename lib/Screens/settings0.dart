// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:mysql1/mysql1.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sample1/Screens/homepage.dart';
import 'package:http/http.dart' as http;
// import 'package:sample1/splash.dart';

class Settings0 extends StatefulWidget {
  const Settings0({Key? key}) : super(key: key);

  @override
  _Settings0State createState() => _Settings0State();
}

class _Settings0State extends State<Settings0> {
  TextEditingController u = TextEditingController();
  TextEditingController p = TextEditingController();

  Future login() async {
    const url = 'https://precision-air.herokuapp.com/';
    var response = await http.post(Uri.parse(url), body: {
      "u": u.text,
      "p": p.text,
    });
    var data = jsonDecode(response.body);

    if (data == "Success") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home(u.text)));
      // print(data);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHANGE PASSWORD'),
        centerTitle: true,
        backgroundColor: HexColor("#415812"),
        shadowColor: Colors.black,
        bottomOpacity: 1.0,
        toolbarOpacity: 1.0,
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
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
                          hintText: 'Old Password',
                          prefixIcon: Icon(
                            Icons.lock,
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
                          hintText: 'New Password',
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
                      width: 290,
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
                        onPressed: () {
                          //         await  login();
                          //          final SharedPreferences sharedPreferences =
                          //      await SharedPreferences.getInstance();
                          //  sharedPreferences.setString('u', u.text);
                        },
                        child: Text(
                          'Change Password',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
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
