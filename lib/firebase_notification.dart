import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

// Step 2: Create Data Models for each variable
class FirebaseData {
  final int value;

  FirebaseData(this.value);
}

// Step 3: Create a ChangeNotifier Class for each variable
class FirebaseDataProvider with ChangeNotifier {
  final String variableName;
  late DatabaseReference _databaseReference;
  late FirebaseData _firebaseData;

  FirebaseDataProvider(this.variableName) {
    _databaseReference = FirebaseDatabase.instance.ref().child(variableName);
    _databaseReference.onValue.listen((event) {
      _firebaseData = FirebaseData(int.parse(event.snapshot.value.toString()));
      notifyListeners();
    });
  }

  FirebaseData get firebaseData => _firebaseData;
}
