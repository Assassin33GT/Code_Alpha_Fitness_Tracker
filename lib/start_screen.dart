import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen>{
  late Stream<StepCount> _countSteps;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = 'Unknown';
  int _step = 0;
  int _steps = 0;

  void requestPermission() async {
    if (await Permission.activityRecognition.isDenied) {
      await Permission.activityRecognition.request();
    }
  }
  @override
  void initState() {
    super.initState();
    requestPermission();
    initPlatformState();
  }

  void initPlatformState() async{
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);
    _countSteps = Pedometer.stepCountStream;
    _countSteps.listen(onStepCount).onError(onStepCountError); 
  }

  void onPedestrianStatusError(error) {
    setState(() {
      _status = 'Pedestrian Status not available';
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  void onStepCount(StepCount event) {
    setState(() {
      _step = event.steps;
      _steps++;
    });
  }

  void onStepCountError(error) {
    setState(() {
      _step = 0;
    });
  }

  void resetStepCount() {
    setState(() {
      _steps = 0;
    });
  }
  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 100,),
            Text(
              'Fitness App',
              style: GoogleFonts.alexBrush(
                color: const Color.fromARGB(255, 183, 56, 47),
                fontSize: 40,
                fontWeight: FontWeight.w800
              ),
            ),
            const SizedBox(height: 450,),
            Text(
              'Steps: $_steps',
              style: GoogleFonts.lato(
                color: Colors.red,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            Text(
              'Status: $_status',
              style: const TextStyle(
                color: Colors.white
              ),
            ),
            const SizedBox(height: 25,),
            ElevatedButton(
            onPressed: resetStepCount,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: const LinearBorder(),
            ),
            child: const Text(
              'Reset Steps',
              style: TextStyle(
                color: Colors.white
              ),
              ),
            ),
            const SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
}
