import 'package:flutter/material.dart';

void main() {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(height: 50, width: 300),
                child: ElevatedButton.icon(
                    icon: Icon(Icons.fire_extinguisher),
                    onPressed: null,
                    label: Text('Button'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      elevation: 25,
                    )),
              ),
              SizedBox(height: 10),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(height: 50, width: 300),
                child: ElevatedButton.icon(
                    icon: Icon(Icons.fire_extinguisher),
                    onPressed: null,
                    label: Text('Button'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 25,
                    )),
              ),
              SizedBox(height: 10),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(height: 50, width: 300),
                child: ElevatedButton.icon(
                    icon: Icon(Icons.fire_extinguisher),
                    onPressed: null,
                    label: Text('Button'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      elevation: 25,
                    )),
              ),
            ],
          ),
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
