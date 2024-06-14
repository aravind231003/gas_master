import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gas_master/api/frebaseapi.dart';

class FirebaseToggleButton extends StatefulWidget {
  final String datapath;
  final String node;
  final String sensor;
  final String onText;
  final String offText;
  FirebaseToggleButton({
    required this.datapath,
    required this.node,
    required this.sensor,
    required this.onText,
    required this.offText,
  });
  @override
  _FirebaseToggleButtonState createState() => _FirebaseToggleButtonState();
}

class _FirebaseToggleButtonState extends State<FirebaseToggleButton> {
  late DatabaseReference database;
  bool isToggled = false;
  @override
  void initState() {
    super.initState();
    database = FirebaseDatabase.instance.ref();
    // Set up Firebase listener to listen for changes in button state
    database.child(widget.datapath).onValue.listen((DatabaseEvent event) {
      if (mounted) {
        setState(() {
          // Update button state based on data received from Firebase
          isToggled = bool.parse(event.snapshot.value.toString());
        });
      }
    });
  }

  void onPressedFunction() {
    // Function to execute when button is toggled ON
    Firebaseapi().sendDataToFirebase(true, widget.node, widget.sensor);
    // Perform action for ON state
  }

  void onUnpressedFunction() {
    // Function to execute when button is toggled OFF
    Firebaseapi().sendDataToFirebase(false, widget.node, widget.sensor);
    // Perform action for OFF state
  }

  void toggleButtonState() {
    // Update button state in Firebase when button is pressed
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference
        .child(widget.datapath)
        .set(!isToggled); // Toggle the current state
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
      child: Text(isToggled ? widget.onText : widget.offText),
    );
  }
}
