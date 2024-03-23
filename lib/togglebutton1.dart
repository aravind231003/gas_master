import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gas_master/homescreen.dart';

class FirebaseToggleButton1 extends StatefulWidget {
  @override
  _FirebaseToggleButtonState createState() => _FirebaseToggleButtonState();
}

class _FirebaseToggleButtonState extends State<FirebaseToggleButton1> {
  late bool isToggled;

  @override
  void initState() {
    super.initState();

    // Set up Firebase listener to retrieve initial button state
    DatabaseReference database = FirebaseDatabase.instance.ref();

    // Set up Firebase listener to listen for changes in button state
    database.child('Fan/fan').onValue.listen((DatabaseEvent event) {
      setState(() {
        // Update button state based on data received from Firebase
        var data = event.snapshot.value.toString();
        isToggled =
            String.fromEnvironment(event.snapshot.value.toString()) == 'true'
                ? true
                : false;
        print(isToggled); // Default to false if data is null
        print(data);
      });
    });
  }

  void onPressedFunction() {
    // Function to execute when button is toggled ON
    sendDataToFirebase(true, 'Fan', 'fan');
    // Perform action for ON state
  }

  void onUnpressedFunction() {
    // Function to execute when button is toggled OFF
    sendDataToFirebase(false, 'Fan', 'fan');
    // Perform action for OFF state
  }

  void toggleButtonState() {
    // Update button state in Firebase when button is pressed
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference
        .child('Fan/fan')
        .set(isToggled); // Toggle the current state
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStatePropertyAll(25),
        fixedSize: MaterialStatePropertyAll(Size(250, 50)),
      ),
      onPressed: () {
        setState(() {
          // Toggle button state locally
          isToggled = !isToggled;
        });
        // Update button state in Firebase
        toggleButtonState();
        // Execute appropriate function based on button state
        if (isToggled) {
          onPressedFunction();
        } else {
          onUnpressedFunction();
        }
      },
      child: Text(isToggled ? 'Fan on' : 'Fan off'),
    );
  }
}
