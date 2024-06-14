import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gas_master/animation.dart';
import 'package:gas_master/api/frebaseapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'homescreen.dart';

class Gaslevel extends StatefulWidget {
  const Gaslevel({super.key});

  @override
  State<Gaslevel> createState() => _GaslevelState();
}

class _GaslevelState extends State<Gaslevel> {
  double _gasLevel = 0;
  double _gas15 = 0.0;
  double _gas19 = 0.0;
  double _gas5 = 0.0;
  double selectedvalue = 0;
  double customvalue = 0.0;
  bool oncanceled = false;
  double customgas = 0.0;

  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  DatabaseReference text1 =
      FirebaseDatabase.instance.ref('textfield1/emptygas');
  DatabaseReference text2 = FirebaseDatabase.instance.ref('textfield2/maxgas');

  int emptygas = 0;
  int maxgas = 0;
  String _selectedGas = '5 kg';
  double gaspercentage = 0;

  List<String> _gasWeights = ['5 kg', '14.2 kg', '19 kg', 'Custom value'];

  @override
  void initState() {
    super.initState();
    DatabaseReference gas = FirebaseDatabase.instance.ref('gas level/output');
    DatabaseReference showvalue =
        FirebaseDatabase.instance.ref('gas calculated/value');
    loadvalue();
    text1.onValue.listen((DatabaseEvent event) {
      if (mounted) {
        setState(() {
          emptygas = int.parse(event.snapshot.value.toString());
        });
      }
    });

    text2.onValue.listen((DatabaseEvent event) {
      if (mounted) {
        setState(() {
          maxgas = int.parse(event.snapshot.value.toString());
        });
      }
    });
    /* showvalue.onValue.listen((DatabaseEvent event) {
      if (mounted) {
        setState(() {
          gaspercentage = double.parse(event.snapshot.value.toString());
          if (gaspercentage < 10) {
            showDialog(
                context: context,
                builder: (BuildContext context) => Dialogbox(
                      title: 'GAS LEVEL ALERT',
                      content:
                          'Your Gas Level is less than 10% .Please book your gas',
                    ));
          }
        });
      }
      print(gaspercentage);
    });*/

    gas.onValue.listen((DatabaseEvent event) {
      if (mounted) {
        setState(() {
          _gasLevel = double.parse(event.snapshot.value.toString());
          _gas5 = ((_gasLevel - 8000 - 450) / 5000) * 100;
          _gas15 = ((_gasLevel - 15300 - 450) / 15000) * 100;
          _gas19 = ((_gasLevel - 18000 - 450) / 19000) * 100;
          customgas = ((_gasLevel - emptygas - 450) / maxgas) * 100;
          if (_selectedGas == '5 kg') {
            if (_gas5 < 10) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialogbox(
                        title: 'GAS LEVEL ALERT',
                        content:
                            'Your Gas Level is less than 10% .Please book your gas',
                      ));
            }
          } else if (_selectedGas == '14.2 kg') {
            if (_gas15 < 10) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialogbox(
                        title: 'GAS LEVEL ALERT',
                        content:
                            'Your Gas Level is less than 10% .Please book your gas',
                      ));
            }
          } else if (_selectedGas == '19 kg') {
            if (_gas19 < 10) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialogbox(
                        title: 'GAS LEVEL ALERT',
                        content:
                            'Your Gas Level is less than 10% .Please book your gas',
                      ));
            }
          } else {
            if (customgas < 10) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialogbox(
                        title: 'GAS LEVEL ALERT',
                        content:
                            'Your Gas Level is less than 10% .Please book your gas',
                      ));
            }
          }
        });
      }
    });
  }

  displayvalue(int value1, int value2) {
    if (_selectedGas == '5 kg') {
      setState(() {
        _gas5 = ((_gasLevel - 8000 - 450) / 5000) * 100;

        if (_gas5 < 0) {
          selectedvalue = 0.0;
        } else {
          selectedvalue = _gas5;
        }
      });
    } else if (_selectedGas == '14.2 kg') {
      setState(() {
        _gas15 = ((_gasLevel - 15300 - 450) / 15000) * 100;

        if (_gas15 < 0) {
          selectedvalue = 0.0;
        } else {
          selectedvalue = _gas15;
        }
      });
    } else if (_selectedGas == '19 kg') {
      setState(() {
        _gas19 = ((_gasLevel - 18000 - 450) / 19000) * 100;
        if (_gas19 < 0) {
          selectedvalue = 0.0;
        } else {
          selectedvalue = _gas19;
        }
      });
    } else {
      setState(() {
        double _customgas = ((_gasLevel - value1 - 450) / value2) * 100;

        if (_customgas < 0) {
          selectedvalue = 0.0;
        } else {
          selectedvalue = _customgas;
        }
      });
    }
    return selectedvalue;
  }

  /*customcalculated(int emptygas, int maxgas) {
    setState(() {
      double _customgas = ((_gasLevel - emptygas) / maxgas) * 100;

      selectedvalue = _customgas;
    });
  }*/

  Future<void> savevalue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('_selectedGas', _selectedGas);
  }

  Future<void> savint(double value, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('$name', value);
  }

  Future<void> loadint(String name, double variable) async {
    final prefs = await SharedPreferences.getInstance();
    final savedvalue = prefs.getDouble('$name') ?? 1;
    setState(() {
      variable = savedvalue;
    });
  }

  Future<void> loadvalue() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedGas = prefs.getString('_selectedGas');

    _selectedGas = selectedGas!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.width),
          painter: GaslevelPainter(
              oncanceled ? 0.0 : displayvalue(emptygas, maxgas)),
        ),
        Text(
          'Gas Level: ${(oncanceled ? 0.0 : displayvalue(emptygas, maxgas)).toStringAsFixed(1)}%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        DropdownButton(
            hint: Text('Select the type of weight'),
            dropdownColor: const Color.fromARGB(255, 124, 202, 238),
            value: _selectedGas,
            items: _gasWeights
                .map((String _gasWeights) => DropdownMenuItem(
                    value: _gasWeights, child: Text(_gasWeights)))
                .toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedGas = newValue!;
              });
              savevalue();
              if (_selectedGas != 'Custom value') {
                setState(() {
                  oncanceled = false;
                });
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Enter the values'),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: TextField(
                              controller: _textFieldController1,
                              decoration: InputDecoration(
                                  labelText: 'Enter empty weight of cylinder'),
                            ),
                          ),
                          SizedBox(height: 10),
                          Flexible(
                            child: TextField(
                              controller: _textFieldController2,
                              decoration: InputDecoration(
                                  labelText:
                                      'Enter the max value of Gas in cylinder'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          setState(() {
                            oncanceled = true;
                          });
                          Navigator.pop(context, 'Cancel');
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            oncanceled = false;
                          });
                          setState(() {
                            emptygas = int.parse(_textFieldController1.text);
                            maxgas = int.parse(_textFieldController2.text);
                          });
                          Firebaseapi().sendDataToFirebase(
                              emptygas, 'textfield1', 'emptygas');
                          Firebaseapi().sendDataToFirebase(
                              maxgas, 'textfield2', 'maxgas');

                          displayvalue(emptygas, maxgas);

                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            }),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStatePropertyAll(25),
            fixedSize: MaterialStatePropertyAll(Size(250, 50)),
          ),
          onPressed: () {
            _launchDialer('+91 9447869164');
          },
          child: Text('BOOK YOUR GAS'),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

void _launchDialer(String phoneNumber) async {
  Uri url = Uri(scheme: 'tel', path: phoneNumber);
  await launchUrl(url);
}
