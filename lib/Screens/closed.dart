// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sample1/Screens/homepage.dart';
import 'package:sample1/Screens/login.dart';
import 'package:sample1/Screens/settings.dart';
import 'package:sample1/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Closed extends StatefulWidget {
  const Closed({ Key? key }) : super(key: key);

  @override
  _ClosedState createState() => _ClosedState();
}

class _ClosedState extends State<Closed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#415812"),
        shadowColor: Colors.black,
        bottomOpacity: 1.0,
        toolbarOpacity: 1.0,
        toolbarHeight: 100,
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Container(
            color: HexColor("#415812"),
            child: Column(
              children: [
                Title(
                    color: HexColor("#415812"),
                    child: Image.asset(
                      'assets/logo.jpg',
                      height: 100,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: HexColor("#415812"),
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => Home(u)));
                    },
                  ),
                ),
                ListTile(
                  tileColor: Colors.grey.shade200,
                  leading: CircleAvatar(
                    backgroundColor: HexColor("#415812"),
                    child: Icon(
                      Icons.check_box,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text('Closed'),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Closed()));
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: HexColor("#415812"),
                    child: Icon(
                      Icons.help,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text('Help'),
                  onTap: () {},
                ),
                ListTile(
                  tileColor: Colors.grey.shade200,
                  leading: CircleAvatar(
                    backgroundColor: HexColor("#415812"),
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Settings()));
                  },
                ),
                SizedBox(
                  height: 300,
                ),
                ListTile(
                  tileColor: Colors.grey.shade200,
                  leading: CircleAvatar(
                    backgroundColor: HexColor("#415812"),
                    child: Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text('Sign Out'),
                  trailing: Icon(Icons.logout),
                  onTap: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await preferences.clear();

                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => Login()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Text('Closed Items'),
      ),
    );
  }
}
