import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gas_master/togglebutton1.dart';
import 'package:gas_master/togglebutton2.dart';
import 'package:url_launcher/url_launcher.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int button = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Center(
          child: Image.asset(
            'images/fire-flame.gif',
            width: 200,
            height: 200,
          ),
        ),
        SizedBox(height: 50),
        Text(
          'Gas Master',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 50),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 25),
              SizedBox(height: 25),
              FirebaseToggleButton1(),
              SizedBox(height: 25),
              FirebaseToggleButton2(),
              SizedBox(height: 25),
              ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStatePropertyAll(25),
                  fixedSize: MaterialStatePropertyAll(Size(250, 50)),
                ),
                onPressed: () {
                  _launchDialer('101');
                },
                child: Text('FIRE STATION'),
              )
            ],
          ),
        ),
      ],
    );
  }
}

sendDataToFirebase(bool data, var node, var sensor) {
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  // Assuming 'sensorData' is the node where data will be stored
  databaseReference.child('$node').set({
    '$sensor': data,
    // Add more data fields as needed
  });
}

void _launchDialer(String phoneNumber) async {
  Uri url = Uri(scheme: 'tel', path: phoneNumber);
  await launchUrl(url);
}

getdata(String path) {
  DatabaseReference database = FirebaseDatabase.instance.ref('$path');
  database.onValue.listen((DatabaseEvent event) {
    final data = event.snapshot.value;
    print(data);
  });
}
