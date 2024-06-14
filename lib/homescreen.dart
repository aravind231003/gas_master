import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gas_master/togglebutton1.dart';
import 'package:url_launcher/url_launcher.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int button = 0;
  int flame = 1;
  int digitalgas = 1;

  @override
  void initState() {
    super.initState();
    DatabaseReference gas = FirebaseDatabase.instance.ref('Gas/output');
    gas.onValue.listen((DatabaseEvent event) {
      setState(() {
        digitalgas = int.parse(event.snapshot.value.toString());

        if (digitalgas == 0) {
          showDialog(
              context: context,
              builder: (BuildContext context) => Dialogbox(
                    title: 'WARNING !!!!',
                    content:
                        'Please Check your gas leakge before turning on the regulator',
                  ));
        }
      });
    });
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('Flame/output1');
    databaseReference.onValue.listen((DatabaseEvent event) {
      setState(() {
        flame = int.parse(event.snapshot.value.toString());
        if (flame == 0) {
          showDialog(
              context: context,
              builder: (BuildContext context) => Dialogbox(
                    title: 'EMERGENCY ALERT !!!!',
                    content: 'FIRE HAS BEEN DETECTED',
                  ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Center(
          child: Image.asset(
            'images/fire-flame.gif',
            width: 200,
            height: 200,
          ),
        ),
        SizedBox(height: 30),
        Text(
          'Gas Master',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 30),
        Text(
          digitalgas == 0 ? 'GAS LEAKAGE DETECTED' : '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 70),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 25),
              FirebaseToggleButton(
                datapath: 'Fan/fan',
                node: 'Fan',
                sensor: 'fan',
                onText: 'Fan ON',
                offText: 'fan OFF',
              ),
              SizedBox(height: 25),
              FirebaseToggleButton(
                datapath: 'Servo/motor',
                node: 'Servo',
                sensor: 'motor',
                onText: 'REGULATOR ON',
                offText: 'REGULATOR OFF',
              ),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
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

class Dialogbox extends StatelessWidget {
  final String title, content;

  Dialogbox({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
