import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 40, left: 15, right: 15),
        child: Text("This App will help caregivers monitor body movement and orientation of the baby as one of the indication of sudden infant death syndrome", style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400
        ),),
      ),
    );
  }
}
