import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gas_master/animation.dart';

class Gaslevel extends StatefulWidget {
  const Gaslevel({super.key});

  @override
  State<Gaslevel> createState() => _GaslevelState();
}

class _GaslevelState extends State<Gaslevel> {
  String realtimevalue = '1';
  var _gasLevel = 100;
  @override
  Widget build(BuildContext context) {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref('UsersData/KbSkscgNamhf99vjwlhRzjOhvjc2/readings/1709544889')
        .child('output1');
    databaseReference.onValue.listen((DatabaseEvent event) {
      setState(() {
        realtimevalue = event.snapshot.value.toString();
      });
    });

    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.width),
          painter: GaslevelPainter(_gasLevel),
        ),
        Text(
          'Gas Level: ${(_gasLevel).toStringAsFixed(1)}%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'flame sensor value:$realtimevalue',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
