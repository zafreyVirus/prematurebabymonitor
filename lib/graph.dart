import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: GraphPage()));
}

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  final DatabaseReference _sensorReference = FirebaseDatabase.instance
      .ref('fusedSensor'); // Firebase path for fused data
  final DatabaseReference _textReference = FirebaseDatabase.instance
      .ref('sleepingPosition'); // Firebase path for text
  List<FlSpot> _spots = [];
  bool _isLoading = true;
  String _sleepingPositionText = "Loading..."; // Default loading text

  @override
  void initState() {
    super.initState();
    _listenToRealtimeData(); // Listen for updates from Firebase
    _listenToTextData(); // Listen for updates to the text data
  }

  void _listenToRealtimeData() {
    _sensorReference.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      List<FlSpot> newSpots = [];
      data.forEach((key, value) {
        double fusedRoll = double.parse(value['fusedRoll'].toString());
        double fusedPitch = double.parse(value['fusedPitch'].toString());
        newSpots.add(FlSpot(fusedPitch, fusedRoll));
      });
      setState(() {
        _spots = newSpots;
        _isLoading = false;
      });
    });
  }

  void _listenToTextData() {
    _textReference.onValue.listen((event) {
      final data = event.snapshot.value;
      setState(() {
        _sleepingPositionText =
            data.toString(); // Update the text from Firebase
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Realtime Baby Motion Graph"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: _spots.length *
                            50.0, // Dynamic width based on points
                        child: LinearChartWidget(spots: _spots),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.08,
                ),
                Container(
                  child: Text(
                    _sleepingPositionText, // Read text from Firebase
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class LinearChartWidget extends StatelessWidget {
  final List<FlSpot> spots;

  const LinearChartWidget({super.key, required this.spots});

  @override
  Widget build(BuildContext context) {
    double minX =
        spots.isNotEmpty ? spots.first.x : 0; // Start from the first point
    double maxX = spots.isNotEmpty
        ? spots.last.x
        : 1; // End at the last point or a default value
    double rangeX = maxX - minX;

    return LineChart(LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          axisNameWidget: const Text(
            'Roll angle',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          axisNameSize: 20,
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              );
            },
            reservedSize: 40,
          ),
        ),
        bottomTitles: AxisTitles(
          axisNameWidget: const Text(
            'Pitch angle',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          axisNameSize: 20,
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              if (value % 1 == 0) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Transform.rotate(
                    angle: 1.5708, // Rotate labels 90 degrees
                    child: Text(
                      value.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
            interval: 1,
            reservedSize: 40,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(show: true),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: Colors.blue,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
        ),
      ],
      minX: minX,
      maxX: maxX + (rangeX == 0 ? 1 : 0), // Ensure some width if only one point
      minY: 0,
      maxY: spots.isNotEmpty
          ? spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) + 1
          : 10,
    ));
  }
}
