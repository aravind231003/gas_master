import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/frebaseapi.dart';
import 'firebase_options.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

@pragma('vm:entry-point')
Future<void> datasend() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Firebaseapi().sendDataToFirebase(false, 'Servo', 'motor');
}

class AlarmFeature extends StatefulWidget {
  @override
  _AlarmFeatureState createState() => _AlarmFeatureState();
}

class _AlarmFeatureState extends State<AlarmFeature> {
  bool _repeatDaily = false;
  TimeOfDay _selectedTime = TimeOfDay(hour: 8, minute: 0); // Default alarm time
  final int alarm1 = 0;
  final int alarm2 = 1;

  @override
  void initState() {
    super.initState();
    // Initialize the alarm manager
    AndroidAlarmManager.initialize();
    // Load the saved selected time
    loadSelectedTime();
    loadvalue();
    if (_repeatDaily) {}
  }

  // Schedule the alarm task
  Future<void> scheduleAlarmTask(TimeOfDay _selectedtime) async {
    final now = DateTime.now();
    final DateTime scheduledDateTime;
    scheduledDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    await AndroidAlarmManager.oneShotAt(scheduledDateTime, alarm1, datasend);
  }

  Future<void> repeatAlarmTask(TimeOfDay _selectedtime) async {
    final now = DateTime.now();
    final DateTime scheduledDateTime;
    scheduledDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    await AndroidAlarmManager.periodic(
        const Duration(hours: 24), alarm1, datasend,
        startAt: scheduledDateTime);
  }

  // Load the saved selected time
  Future<void> loadSelectedTime() async {
    final prefs = await SharedPreferences.getInstance();
    final savedHour = prefs.getInt('selected_hour') ?? 8;
    final savedMinute = prefs.getInt('selected_minute') ?? 0;
    setState(() {
      _selectedTime = TimeOfDay(hour: savedHour, minute: savedMinute);
    });
  }

  // Save the selected time
  Future<void> saveSelectedTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selected_hour', _selectedTime.hour);
    await prefs.setInt('selected_minute', _selectedTime.minute);
  }

  Future<void> savevalue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('repeatdaily', _repeatDaily);
  }

  Future<void> loadvalue() async {
    final prefs = await SharedPreferences.getInstance();
    final repeatdaily = prefs.getBool('repeatdaily') ?? false;
    setState(() {
      _repeatDaily = repeatdaily;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'TIMER TO TURN OFF REGULATOR',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Selected Time: ${_selectedTime.format(context)}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStatePropertyAll(25),
              fixedSize: MaterialStatePropertyAll(Size(250, 50)),
            ),
            onPressed: () {
              showTimePicker(
                context: context,
                initialTime: _selectedTime,
              ).then((value) {
                if (value != null) {
                  setState(() {
                    _selectedTime = value;
                  });
                  saveSelectedTime(); // Save the selected time
                }
              });
            },
            child: Text('Select the Time'),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStatePropertyAll(25),
              fixedSize: MaterialStatePropertyAll(Size(250, 50)),
            ),
            onPressed: () async {
              try {
                await scheduleAlarmTask(_selectedTime);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Timer set')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error in setting timer: $e')),
                );
              }
            },
            child: Text('Set timer'),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStatePropertyAll(25),
              fixedSize: MaterialStatePropertyAll(Size(250, 50)),
            ),
            onPressed: () {
              AndroidAlarmManager.cancel(alarm1);
            },
            child: Text('Cancel Timer'),
          ),
          SizedBox(height: 20),
          SwitchListTile(
            title: Text('Repeat Daily'),
            value: _repeatDaily,
            onChanged: (value) {
              setState(() {
                _repeatDaily = value;
              });
              savevalue();
              if (_repeatDaily == true) {
                repeatAlarmTask(_selectedTime);
              } else {
                AndroidAlarmManager.cancel(alarm2);
              }
            },
          ),
        ],
      ),
    );
  }
}
