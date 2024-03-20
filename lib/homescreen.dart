import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:slidable_button/slidable_button.dart';

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
            'images/fire.png',
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
              HorizontalSlidableButton(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 15,
                buttonWidth: 70.0,
                autoSlide: false,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                buttonColor: Theme.of(context).primaryColor,
                dismissible: false,
                initialPosition: SlidableButtonPosition.start,
                label: Center(child: Text('MOTOR')),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('OFF'),
                      Text('ON'),
                    ],
                  ),
                ),
                onChanged: (position) {
                  if (position == SlidableButtonPosition.start) {
                    sendDataToFirebase(0, 'Servo', 'motor');
                  }
                  if (position == SlidableButtonPosition.end) {
                    sendDataToFirebase(1, 'Servo', 'motor');
                  }
                },
              ),
              SizedBox(height: 25),
              HorizontalSlidableButton(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 15,
                buttonWidth: 70.0,
                autoSlide: false,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                buttonColor: Theme.of(context).primaryColor,
                dismissible: false,
                initialPosition: SlidableButtonPosition.start,
                label: Center(child: Text('FAN')),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('OFF'),
                      Text('ON'),
                    ],
                  ),
                ),
                onChanged: (position) {
                  if (position == SlidableButtonPosition.start) {
                    sendDataToFirebase(0, 'Fan', 'fan');
                  }
                  if (position == SlidableButtonPosition.end) {
                    sendDataToFirebase(1, 'Fan', 'fan');
                  }
                },
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}

sendDataToFirebase(int data, var node, var sensor) {
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  // Assuming 'sensorData' is the node where data will be stored
  databaseReference.child('$node').set({
    '$sensor': data,
    // Add more data fields as needed
  }).then((value) {
    print('Data sent successfully');
  }).catchError((error) {
    print('Failed to send data: $error');
  });
}
