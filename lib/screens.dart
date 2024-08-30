import 'package:fitness_tracker/data/goals.dart';
import 'package:fitness_tracker/exercise_screen.dart';
import 'package:fitness_tracker/goals_screen.dart';
import 'package:fitness_tracker/instruction_screen.dart';
import 'package:fitness_tracker/start_screen.dart';
import 'package:fitness_tracker/workouts_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState(){
    return _ScreensState();
  }
}

class _ScreensState extends State<Screens> {
  var screenSwitch = 'start-screen';
  int currentLevel = 0;
  String nameOfLevel = 'Level 1';
  String nameOfNextLevel = 'Level 2';
  var noOfLevel = levels;
  String bg = 'android/assets/images/main_screen_image1.jpg';
  int index = 0;
  List<int> completed = [0,0,0];
  List<int> check = [0,0,0];
  
  void switchScreen(String screen) {
    setState(() {
      screenSwitch = screen;
    });
  }

  void switchLevel() {
    setState(() {
      if (currentLevel < 2) {
        currentLevel++;
        nameOfLevel = 'Level ${currentLevel+1}';
        nameOfNextLevel = 'Level ${currentLevel+2}';
        if (currentLevel == 2){
          nameOfNextLevel = 'Level 1';
        }
      }else{
        currentLevel = 0;
        nameOfLevel = 'Level 1';
        nameOfNextLevel = 'Level 2';
      }
    });
  }

  void exerciseWindow(int index) {
    setState(() {
      this.index = index;
      screenSwitch = 'exercise-screen';
    });
  }

  void goBackToGoals() {
    setState(() {
      screenSwitch = 'goal-screen';
    });
  }

  void increaseFinished(int x) {
    setState(() {
      if(noOfLevel[currentLevel].finished[x] < 2){
        noOfLevel[currentLevel].finished[x]++;
      }
    });
  }

  void resetLevels() {
    setState(() {
      for(int i = 0; i<completed.length; i++){
        completed[i] = 0;
      }
      /*levels[0].finished = [0,0,0,0,0,0,0,0,0,0];
      levels[1].finished = [0,0,0,0,0,0,0,0,0,0];
      levels[2].finished = [0,0,0,0,0,0,0,0,0,0];*/
      currentLevel = 0;
    });
  }

  void waiting() {
      Timer(const Duration(seconds: 5), () {
        setState(() {
          levels[currentLevel].finished = [0,0,0,0,0,0,0,0,0,0];
        });
      });
  }

  /*//To save the state
  Future<void> saveAppState(int stepCount) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('noOfLevel', noOfLevel[0].finished.toString());
  }

  //To get the last state
  Future<int> loadAppState() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('stepCount') ?? 0;
}*/

  @override
  Widget build(context) {
    Widget activeScreen = const StartScreen();
   
    if(levels[0].finished.every((value) => value == 2 && check[0] == 0 && completed[0] != 5)){
        completed[0]++;
        check[0]++;
      }
    if(levels[1].finished.every((value) => value == 2 && check[1] == 0 && completed[1] != 5)){
        completed[1]++;
        check[1]++;
      }
    if(levels[2].finished.every((value) => value == 2 && check[2] == 0 && completed[2] != 5)){
        completed[2]++;
        check[2]++;
      }
    if(levels[0].finished.every((value) => value != 2 && check[0] != 0)){
        check[0] = 0;
      }
    if(levels[1].finished.every((value) => value != 2 && check[1] != 0)){
        check[1] = 0;
      }
    if(levels[2].finished.every((value) => value != 2 && check[2] != 0)){
        check[2] = 0;
      }
    if(levels[currentLevel].finished.every((value) => value == 2 && completed[currentLevel] != 5)){
      waiting();
    }

    if(screenSwitch == 'start-screen') {
      activeScreen = const StartScreen();
    }
    if(screenSwitch == 'workouts-screen') {
      activeScreen = WorkoutsScreen(noOfLevel, completed, resetLevels, goBackToGoals);
    }
    if(screenSwitch == 'goal-screen') {
      activeScreen = GoalsScreen(noOfLevel[currentLevel], nameOfLevel, nameOfNextLevel, completed[currentLevel], switchLevel, exerciseWindow);
    }
    if(screenSwitch == 'exercise-screen') {
      activeScreen = ExerciseScreen(noOfLevel[currentLevel], index, goBackToGoals, increaseFinished);
    }
    if(screenSwitch == 'instruction-screen') {
      activeScreen = const InstructionScreen();
    }
    
    setState(() {
      if (screenSwitch != 'start-screen') {
        bg = 'android/assets/images/main_screen_image2.jpg';
      }else{
        bg = 'android/assets/images/main_screen_image1.jpg';
      }
    });
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
                  title: const SizedBox(
                    width: 280,
                    child: Text(
                      'Fitness App',
                      textAlign: TextAlign.center,
                      ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 250, 10, 10),
                ),
        drawer: NavigationDrawer(switchScreen),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bg),
              fit: BoxFit.cover
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer(this.switchScreen, {super.key});

  final void Function (String screen) switchScreen;

  @override
  Widget build(context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );

  Widget buildHeader(context) => Container(
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ),
  );

  Widget buildMenuItems(context) => Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16,
      children: [
      ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text('Home'),
        onTap: () {
          Navigator.of(context).pop();
          switchScreen('start-screen');
        },
      ),
      ListTile(
        leading: const Icon(Icons.model_training),
        title: const Text('Workouts'),
        onTap: () {
          Navigator.of(context).pop();
          switchScreen('workouts-screen');
        
        },
      ),
      ListTile(
        leading: const Icon(Icons.star_border_outlined),
        title: const Text('Goals'),
        onTap: () {
          Navigator.of(context).pop();
          switchScreen('goal-screen');
        },
      ),
      ListTile(
        leading: const Icon(Icons.warning_amber_outlined),
        title: const Text('Instructions'),
        onTap: () {
          Navigator.of(context).pop();
          switchScreen('instruction-screen');
        },
      ),
      ]
    ),
  );
}