import 'package:baby_monitor/About.dart';
import 'package:baby_monitor/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:baby_monitor/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:baby_monitor/login.dart';
import 'package:baby_monitor/graph.dart';
import 'firebase_options.dart';
import 'Contact_us.dart';
import 'Settings.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baby monitoring app',
      routes: {
        '/': (context) => SplashScreen(
              child: Home(),
            ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => Home(),
        '/graph': (context) => GraphPage()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class Home extends StatefulWidget {
  Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseReference _sleepingPositionReference =
      FirebaseDatabase.instance.ref('sleepingPosition');
  final DatabaseReference _fusedSensorReference =
      FirebaseDatabase.instance.ref('fusedSensor');

  String _sleepingPositionText = "Loading..."; // For sleeping position
  String _anglePitch = "Loading..."; // For pitch angle
  String _angleRoll = "Loading..."; // For roll angle

  @override
  void initState() {
    super.initState();
    _listenToSleepingPosition(); // Listen for changes in sleeping position
    _listenToFusedSensorData(); // Listen for changes in sensor data
  }

  void _listenToSleepingPosition() {
    _sleepingPositionReference.onValue.listen((event) {
      final data = event.snapshot.value;
      setState(() {
        _sleepingPositionText = data.toString(); // Update text from Firebase
      });
    });
  }

  void _listenToFusedSensorData() {
    _fusedSensorReference.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      if (data != null) {
        setState(() {
          _anglePitch = data['fusedPitch'].toString();
          _angleRoll = data['fusedRoll'].toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              color: Colors.white70,
              onPressed: () {},
              icon: Icon(Icons.notifications),
            )
          ],
          leading: Builder(
            builder: (context) {
              return IconButton(
                color: Colors.black,
                icon: const Icon(
                  Icons.menu,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          backgroundColor: Colors.lightBlueAccent,
          title: Text(
            "Premature baby monitor",
            style: TextStyle(color: Colors.black),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  image: DecorationImage(
                      image: AssetImage("assets/Drawer.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Text(
                      "Premature baby monitor",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              ListTile(
                leading: Icon(Icons.home_outlined),
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.mail_outline),
                title: const Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Contactus()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person_outlined),
                title: const Text(
                  'About',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings_outlined),
                title: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: const Text(
                  'Share',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: Image.asset(
                            "assets/homeImage.png",
                            fit: BoxFit.fill,
                          ),
                          decoration:
                              BoxDecoration(color: Colors.lightBlueAccent),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Text(
                          _sleepingPositionText, // Dynamic text from Firebase
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings()),
                            );
                          },
                          icon: Icon(Icons.settings_outlined),
                        ),
                        IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => GraphPage()),
                            // );
                          },
                          icon: Icon(Icons.insert_chart_outlined),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Text(
                      "Movement",
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'PitchAngle',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "$_anglePitch", // Display pitch angle
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "RollAngle",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "$_angleRoll", // Display roll angle
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
