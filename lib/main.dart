import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gas_master/api/frebaseapi.dart';
import 'package:gas_master/gas%20level.dart';
import 'package:gas_master/homescreen.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebaseapi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gas Master',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> tabWidget = [Homescreen(), Gaslevel()];
  int indexNum = 0;
  @override
  Widget build(BuildContext context) {
    //Color color = _getColorForGasLevel(_gasLevel);
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/wallpaper.webp'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 10.0,
          backgroundColor: const Color.fromARGB(255, 241, 20, 5),
          title: Text('Gas Master'),
        ),
        body: tabWidget.elementAt(indexNum),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.red,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.gas_meter),
              label: "Gas Level",
              backgroundColor: Colors.red,
            )
          ],
          currentIndex: indexNum,
          onTap: (int index) => setState(() {
            indexNum = index;
          }),
        ),
      ),
    );
  }
}

void listenForUpdates() {
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  databaseReference.onValue.listen((DatabaseEvent event) {
    print('Data: ${event.snapshot.value}');
  });
}
//Color _getColorForGasLevel(double gasLevel) {
 // if (gasLevel <= 0.2) {
   // return Colors.red;
  //} else if (gasLevel > 0.2 && gasLevel <= 0.7) {
    //return Colors.orange;
  //} else {
    //return Colors.green;
  //}
//}
