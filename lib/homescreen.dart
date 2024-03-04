import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int button = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 100,
          child: Center(
            child: Image.asset(
              'images/fire.png',
              width: 200,
              height: 200,
            ),
          ),
        ),
        Positioned(
          left: 150,
          right: 0,
          top: 350,
          child: Text(
            'Gas Master',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
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
                    onPressed: () => setState(() {
                          button = button + 1;
                        }),
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
                SizedBox(height: 50),
                Text(
                  'button value:$button',
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
