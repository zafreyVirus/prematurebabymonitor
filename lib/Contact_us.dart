import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class Contactus extends StatelessWidget {
  const Contactus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: ContactUs(
          cardColor: Colors.white54,
          textColor: Colors.grey,
          avatarRadius: 70,
          logo: const AssetImage('assets/Drawer.jpg'),
          email: 'getrudengoma848@gmail.com',
          companyName: 'GMG Neocare',
          companyColor: Colors.black,
          dividerThickness: 2,
          phoneNumber: '+265 995 92 52 48',
          taglineColor: Colors.white,
        ),
      ),
    );
  }
}
