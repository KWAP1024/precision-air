// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_collection_literals, prefer_if_null_operators, prefer_typing_uninitialized_variables, unused_local_variable, avoid_init_to_null, unnecessary_null_comparison

// import 'dart:html';

// import 'dart:html';
// import 'dart:io';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysql1/mysql1.dart';
import 'package:sample1/Screens/closed.dart';
import 'package:sample1/Screens/login.dart';
import 'package:sample1/Screens/settings.dart';
import 'package:sample1/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';

// void main() {
//   runApp(const Home());
// }

class Home extends StatefulWidget {
  const Home(String text, {Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        date1 = pickedDate;
      });
    }
  }

  File? _image = null;
  final picker = ImagePicker();
  Future choiceImage() async {
    var pickerImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickerImage!.path);
    });
  }

  Future choiceimage() async {
    var pickerImage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickerImage!.path);
    });
  }

  Future upload() async {
    const url = 'https://precision-air.herokuapp.com/data.php';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['type'] = type.toString();
    request.fields['discipline'] = discipline.toString();
    request.fields['indicator'] = indicator.toString();
    request.fields['confidentialy'] = confidentialy.toString();
    request.fields['date'] = date1.toString();
    request.fields['selectedTime'] = selectedTime.toString();
    request.fields['location'] = location.toString();
    request.fields['described'] = described.toString();
    request.fields['suggest'] = suggest.toString();
    request.fields['likelihood'] = likelihood.toString();
    request.fields['consequence'] = consequence.toString();
    // var pic = await http.MultipartFile.fromPath("image", _image!.path);
    // request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Home(u)));
    } else {
      Fluttertoast.showToast(
        msg: 'Input Fields contain an Error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    }
  }

  TextEditingController location = TextEditingController();
  TextEditingController described = TextEditingController();
  TextEditingController suggest = TextEditingController();

  var selectedTime;
  var date1;
  var type;
  List listItem = ['Hazards', 'Oshea'];
  var discipline;
  List listItem2 = ['FLT', 'CAB', 'MNT', 'GRH', 'CGO'];
  var indicator;
  // List listItem3 = ['FLT1', 'CAB1', 'MNT1', 'GRH1', 'CGO1'];
  var confidentialy;
  List listItem4 = ['OPEN', 'CONFIDENTIAL'];
  var likelihood;
  List listItem5 = [
    '1 - Extremly Imporable',
    '2 - Improbable',
    '3 - Remote',
    '4 - Occasional',
    '5 - Frequent'
  ];
  var consequence;
  List listItem6 = [
    '1 - Negligible',
    '2 - Minor',
    '3 - Major',
    '4 - Hazardous',
    '5 - Catastrophic'
  ];

  Future<void> _show() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        selectedTime = result.format(context);
      });
    }
  }

  Future insert() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'us-cdbr-east-04.cleardb.com',
        port: 3306,
        user: 'bf15ab7159f988',
        db: 'heroku_a7874bf1ef4af48',
        password: 'ee55bd44'));

    var result = await conn.query(
        'insert into news7 ( type, discipline, indicator, date1, selectedTime, location, described, suggest, likelihood, consequence) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          type.toString(),
          discipline.toString(),
          indicator.toString(),
          date1.toString(),
          selectedTime.toString(),
          location.text,
          described.text,
          suggest.text,
          likelihood.toString(),
          consequence.toString(),
        ]);
    // print('Inserted row id=${result.insertId}');

    await conn.close();
  }

  var select;
  // var data = list();

  // Future getdata() async {
  //   const url = 'https://precision-air.herokuapp.com/view.php';
  //   var response = await http.get(Uri.parse(url));
  //   var jsonbody = response.body;
  //   var jsondata = jsonDecode(jsonbody);

  //   setState(() {
  //     data = jsondata;
  //   });
  //   print(jsondata);
  // }
  String stringResponse = '';
  List listResponse = [];
  Map mapResponse = {};
  Map mapOfFacts = {};
  List data = [];

  // Map maphome = {};

  Future getdata() async {
    http.Response response;
    const url = 'https://precision-air.herokuapp.com/view.php';
    response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        // listOfFacts = mapOfFacts['fixtures'];
        // mapResponse = mapOfFacts['data'];
        // listResponse = mapResponse['fixtures'];
        // // maphome = listResponse[home_name];
      });
    } //
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.black,
        bottomOpacity: 1.0,
        toolbarOpacity: 1.0,
        toolbarHeight: 100,
        title: Text('PW - QSS', style: TextStyle(color: HexColor("#fdbe33"))),
        actions: <Widget>[],
        centerTitle: true,
        backgroundColor: HexColor("#415812"),
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
      // ?? 'default'
      body: SingleChildScrollView(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: IconButton(
                  iconSize: 130,
                  icon: ClipOval(child: Image.asset('assets/user.jpg')),
                  onPressed: () {},
                ),
              ),
              Text(
                u != null ? u : 'Loading...',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: Divider(),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 10),
                    child: Column(
                      children: [
                        Title(
                            color: Colors.black,
                            child: Text('SECTION:',
                                style: TextStyle(fontWeight: FontWeight.w900))),
                        Text('ORG')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 10),
                    child: Column(
                      children: [
                        Title(
                            color: Colors.black,
                            child: Text(
                              'RANK:',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            )),
                        Text('SAFETY MANAGER')
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 300, top: 20),
                child: Text('EMAIL:',
                    style: TextStyle(fontWeight: FontWeight.w900)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 300),
                child: Text('PHONE:',
                    style: TextStyle(fontWeight: FontWeight.w900)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 80, left: 80, top: 20),
          child: Text(
            'The information supplied in this form will only be used to enhance safety',
            style: TextStyle(color: HexColor("#415812")),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Title(
                      color: Colors.black,
                      child: Text('Type',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: HexColor("#415812"), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.arrow_downward),
                        style: TextStyle(color: Colors.black, fontSize: 22),
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Text('Select'),
                        value: type,
                        onChanged: (newValue) {
                          setState(() {
                            type = newValue;
                          });
                        },
                        items: listItem.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem != null
                                ? valueItem
                                : 'default value'),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Title(
                      color: Colors.black,
                      child: Text('Discipline',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: HexColor("#415812"), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.arrow_downward),
                        style: TextStyle(color: Colors.black, fontSize: 22),
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Text('Select'),
                        value: discipline,
                        onChanged: (newValue2) {
                          setState(() {
                            discipline = newValue2;
                          });
                        },
                        items: listItem2.map((valueItem2) {
                          return DropdownMenuItem(
                            value: valueItem2,
                            child: Text(valueItem2 != null
                                ? valueItem2
                                : 'default value'),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Title(
                      color: Colors.black,
                      child: Text('Indicator(Operational Event)',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: HexColor("#415812"), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.arrow_downward),
                        style: TextStyle(color: Colors.black, fontSize: 22),
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Text('Select'),
                        value: discipline,
                        items: data.map((list) {
                          return DropdownMenuItem(
                            child: Text(list['name1']),
                            value: list['name1'],
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            select = value;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Title(
                      color: Colors.black,
                      child: Text('Confidentiality',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: HexColor("#415812"), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.arrow_downward),
                        style: TextStyle(color: Colors.black, fontSize: 22),
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Text('Select'),
                        value: confidentialy,
                        onChanged: (newValue4) {
                          setState(() {
                            confidentialy = newValue4;
                          });
                        },
                        items: listItem4.map((valueItem4) {
                          return DropdownMenuItem(
                            value: valueItem4,
                            child: Text(valueItem4 != null
                                ? valueItem4
                                : 'default value'),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Title(
                      color: Colors.black,
                      child: Text('Date Of Occurance',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  Container(
                    height: 50,
                    width: 375,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor("#415812"))),
                    child: Row(
                      children: [
                        Text(date1.toString() != null
                            ? date1.toString()
                            : 'No date Selected'),
                        Padding(
                          padding: const EdgeInsets.only(left: 135),
                          child: IconButton(
                              onPressed: () => _selectDate(context),
                              icon: Icon(Icons.calendar_today_rounded)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Title(
                      color: Colors.black,
                      child: Text('LocalTime:',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: HexColor("#415812"), width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 160),
                          child: Row(
                            children: [
                              Text(selectedTime != null ? selectedTime : ''),
                              IconButton(
                                  onPressed: _show, icon: Icon(Icons.timer)),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Title(
                      color: Colors.black,
                      child: Text('Location',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextField(
                      controller: location,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 40.0),
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
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Title(
                      color: Colors.black,
                      child: Text(
                          'Please, fully describe the occurence/hazards',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextField(
                      controller: described,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 40.0),
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
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Title(
                      color: Colors.black,
                      child: Text(
                          'Suggestions on how to prevent similar occurence',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextField(
                      controller: suggest,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 40.0),
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
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Title(
                      color: Colors.black,
                      child: Text('Attach additional page if requiired',
                          style: TextStyle(fontWeight: FontWeight.w900))),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor("#415812"))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            height: 50,
                            width: 50,
                            child: _image == null
                                ? Text('No Image Selected')
                                : Image.file(_image!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 190),
                          child: IconButton(
                              onPressed: () {
                                choiceImage();
                              },
                              icon: Icon(Icons.attach_file_outlined)),
                        ),
                        IconButton(
                            onPressed: () {
                              choiceimage();
                            },
                            icon: Icon(Icons.camera_alt)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Title(
                        color: Colors.black,
                        child: Text(
                            'In your opinion, what is likelihood of a similar occurence happenning again?',
                            style: TextStyle(fontWeight: FontWeight.w900))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: HexColor("#415812"), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.arrow_downward),
                        style: TextStyle(color: Colors.black, fontSize: 22),
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Text('Select'),
                        value: likelihood,
                        onChanged: (newValue5) {
                          setState(() {
                            likelihood = newValue5;
                          });
                        },
                        items: listItem5.map((valueItem5) {
                          return DropdownMenuItem(
                            value: valueItem5,
                            child: Text(valueItem5 != null
                                ? valueItem5
                                : 'default value'),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Title(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                            'What do you consider could be worst possible consequences if this occurence did happen again?',
                            style: TextStyle(fontWeight: FontWeight.w900)),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: HexColor("#415812"), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.arrow_downward),
                        style: TextStyle(color: Colors.black, fontSize: 22),
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Text('Select'),
                        value: consequence,
                        onChanged: (newValue6) {
                          setState(() {
                            consequence = newValue6;
                          });
                        },
                        items: listItem6.map((valueItem6) {
                          return DropdownMenuItem(
                            value: valueItem6,
                            child: Text(valueItem6 != null
                                ? valueItem6
                                : 'default value'),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 370,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(HexColor("#415812")),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(HexColor("#415812")),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: HexColor("#415812"))))),
                  onPressed: () async {
                    // k();
                    await insert();
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => Home(u)));
                  },
                  child: Text(
                    'Submit Report',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 90,
            )
          ],
        )
      ])),
    );
  }
}
