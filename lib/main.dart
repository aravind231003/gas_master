import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gas_master/api/frebaseapi.dart';
import 'animation.dart';
import 'firebase_options.dart';

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
  @override
  Widget build(BuildContext context) {
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
        body: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                top: 100,
                child: GasCylinderIndicator(gasLevel: .75)),
            Positioned(
              left: 0,
              right: 0,
              bottom: 100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                        icon: Icon(Icons.fire_extinguisher),
                        onPressed: null,
                        label: Text('Button'),
                        style: ButtonStyle(
                            elevation: MaterialStatePropertyAll(25),
                            fixedSize: MaterialStatePropertyAll(Size(300, 50)),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.redAccent))),
                    SizedBox(height: 25),
                    ElevatedButton.icon(
                        icon: Icon(Icons.fire_extinguisher),
                        onPressed: null,
                        label: Text('Button'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.redAccent),
                          elevation: MaterialStatePropertyAll(25),
                          fixedSize: MaterialStatePropertyAll(Size(300, 50)),
                        )),
                    SizedBox(height: 25),
                    ElevatedButton.icon(
                        icon: Icon(Icons.fire_extinguisher),
                        onPressed: null,
                        label: Text('Button'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.redAccent),
                          elevation: MaterialStatePropertyAll(25),
                          fixedSize: MaterialStatePropertyAll(Size(300, 50)),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),

        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
