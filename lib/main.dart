import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gas_master/alaram.dart';
import 'package:gas_master/api/frebaseapi.dart';
import 'package:gas_master/gas%20level.dart';
import 'package:gas_master/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_notification.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

String dropdownselection = '5 kg';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebaseapi().initNotifications();
  Firebaseapi().initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final firebaseDataProvider1 = FirebaseDataProvider('Flame/output1');
  final firebaseDataProvider3 = FirebaseDataProvider('Gas/output');
  firebaseDataProvider1.addListener(() {
    final data = firebaseDataProvider1.firebaseData;
    if (data.value == 0) {
      Firebaseapi()
          .sendPushNotification('EMERGENCY ALERT', 'FIRE LEAKAGE DETECTED ');
    }
  });

  firebaseDataProvider3.addListener(() {
    final data = firebaseDataProvider3.firebaseData;
    if (data.value == 0) {
      Firebaseapi()
          .sendPushNotification('EMERGENCY ALERT', 'GAS LEAKAGE DETECTED');
    }
  });
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
  List<Widget> tabWidget = [
    Homescreen(),
    Gaslevel(),
    AlarmFeature(),
  ];
  int indexNum = 0;
  Future<void> loadvalue() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedGas = prefs.getString('_selectedGas');
    dropdownselection = selectedGas!;
  }

  @override
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
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: "Timer",
              backgroundColor: Colors.amber,
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

//void listenForUpdates() {
//DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
//databaseReference.onValue.listen((DatabaseEvent event) {
//print('Data: ${event.snapshot.value}');
//});
//}
//Color _getColorForGasLevel(double gasLevel) {
// if (gasLevel <= 0.2) {
// return Colors.red;
//} else if (gasLevel > 0.2 && gasLevel <= 0.7) {
//return Colors.orange;
//} else {
//return Colors.green;
//}
//}

