import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gas_master/api/frebaseapi.dart';

class FirebaseToggleButton2 extends StatefulWidget {
  @override
  _FirebaseToggleButtonState createState() => _FirebaseToggleButtonState();
}

class _FirebaseToggleButtonState extends State<FirebaseToggleButton2> {
  late bool isToggled;

  @override
  void initState() {
    super.initState();

    // Set up Firebase listener to retrieve initial button state
    DatabaseReference database = FirebaseDatabase.instance.ref();

    // Set up Firebase listener to listen for changes in button state
    database.child('Servo/motor').onValue.listen((DatabaseEvent event) {
      setState(() {
        // Update button state based on data received from Firebase

        isToggled =
            String.fromEnvironment(event.snapshot.value.toString()) == 'true'
                ? true
                : false;
        // Default to false if data is null
      });
    });
  }

  void onPressedFunction() {
    // Function to execute when button is toggled ON
    Firebaseapi().sendDataToFirebase(true, 'Servo', 'motor');
    // Perform action for ON state
  }

  void onUnpressedFunction() {
    // Function to execute when button is toggled OFF
    Firebaseapi().sendDataToFirebase(false, 'Servo', 'motor');
    // Perform action for OFF state
  }

  void toggleButtonState() {
    // Update button state in Firebase when button is pressed
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference
        .child('Servo/motor')
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
      child: Text(isToggled ? 'Regulator ON' : 'Regulator OFF'),
    );
  }
}
