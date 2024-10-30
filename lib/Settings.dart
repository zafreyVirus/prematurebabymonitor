import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitched = false;
  bool SwitchBuzzer = false;
  bool SwitchLED = false;
  bool SwitchSMS = false;

  // List to store the status of each card
  List<bool> statuses = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    //Write to database
    //Buzzer, LED and SMS setting Notification
    DatabaseReference ref = FirebaseDatabase.instance.ref("Notification/");
    ref.update({
      "Buzzer": statuses[0],
      "LED": statuses[1],
      "SMS": statuses[2],
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                "Choose notification type:",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Text("Buzzer",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    trailing: Switch(
                        activeColor: Colors.lightBlueAccent,
                        value: statuses[0],
                        onChanged: (value) {
                          setState(() {
                            statuses[0] = value;
                          });
                        }),
                  ),
                  ListTile(
                    leading: Text("Blinking LED",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    trailing: Switch(
                        activeColor: Colors.lightBlueAccent,
                        value: statuses[1],
                        onChanged: (value) {
                          setState(() {
                            statuses[1] = value;
                          });
                        }),
                  ),
                  ListTile(
                    leading: Text("SMS",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    trailing: Switch(
                        activeColor: Colors.lightBlueAccent,
                        value: statuses[2],
                        onChanged: (value) {
                          setState(() {
                            statuses[2] = value;
                          });
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
