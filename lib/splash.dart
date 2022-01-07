// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:sample1/Screens/homepage.dart';
import 'package:sample1/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

var u;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatortohome();
  }

  _navigatortohome() async {
    await getValidationData().whenComplete(() async {
      await Future.delayed(Duration(seconds: 5), () {});
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => u == null ? Login() : Home(u)));
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obatinphone = sharedPreferences.get('u');
    setState(() {
      u = obatinphone;
    });
    print(u);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
