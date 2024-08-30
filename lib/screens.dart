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
  
  @override
  void initState() {
    super.initState();
    _loadSavedCompletedS();
    getPrefss();
  }

  Future<void> savedCompleted(List<int> completed, List<int> check, List<int>finished1, List<int>finished2, List<int>finished3) async{
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    SharedPreferences prefs3 = await SharedPreferences.getInstance();
    SharedPreferences prefs4 = await SharedPreferences.getInstance();

    SharedPreferences prefs5 = await SharedPreferences.getInstance();
    SharedPreferences prefs6 = await SharedPreferences.getInstance();
    SharedPreferences prefs7 = await SharedPreferences.getInstance();

    List<SharedPreferences> prefss = [];

    for(int i = 0;i<30;i++)
    {
      prefss[i] = await SharedPreferences.getInstance();
    }
    for(int i = 0;i<30;i++)
    {
      if(i >= 0 && i < 10){
        prefss[i].setInt('finished${[i]}', finished1[i]);
      }
      if(i >= 10 && i < 20){
        prefss[i].setInt('finished${[i]}', finished2[i - 10]);
      }
      if(i >= 20 && i < 30){
        prefss[i].setInt('finished${[i]}', finished3[i - 20]);
      }
    }
    prefs2.setInt('completed1',completed[0]);
    prefs3.setInt('completed2',completed[1]);
    prefs4.setInt('completed3',completed[2]);

    prefs5.setInt('check1', check[0]);
    prefs6.setInt('check2', check[1]);
    prefs7.setInt('check3', check[2]);

  }

  Future<void> getPrefss() async{
    final prefss = [];

    for(int i = 0;i<30;i++)
    {
      prefss[i] = await SharedPreferences.getInstance();
    }
    for(int i = 0;i<30;i++)
    {
      if(i >= 0 && i < 10){
        noOfLevel[0].finished[i] = prefss[i].getInt('finished${[i]}');
      }
      if(i >= 10 && i < 20){
        noOfLevel[1].finished[i] = prefss[i].getInt('finished${[i]}');
      }
      if(i >= 20 && i < 30){
        noOfLevel[2].finished[i] = prefss[i].getInt('finished${[i]}');
      }
    }
  }

  Future<int> getPrefs2() async{
    final prefs2 = await SharedPreferences.getInstance();
    return prefs2.getInt('completed1') ?? 0;
  }
  Future<int> getPrefs3() async{
    final prefs3 = await SharedPreferences.getInstance();
    return prefs3.getInt('completed2') ?? 0;
  }
  Future<int> getPrefs4() async{
    final prefs4 = await SharedPreferences.getInstance();
    return prefs4.getInt('completed3') ?? 0;
  }
  Future<int> getPrefs5() async{
    final prefs5 = await SharedPreferences.getInstance();
    return prefs5.getInt('check1') ?? 0;
  }
  Future<int> getPrefs6() async{
    final prefs6 = await SharedPreferences.getInstance();
    return prefs6.getInt('check2') ?? 0;
  }
  Future<int> getPrefs7() async{
    final prefs7 = await SharedPreferences.getInstance();
    return prefs7.getInt('check3') ?? 0;
  }
  
  Future<void> _loadSavedCompletedS() async {
    completed[0] = await getPrefs2();
    completed[1] = await getPrefs3();
    completed[2] = await getPrefs4();

    check[0] = await getPrefs5();
    check[1] = await getPrefs6();
    check[2] = await getPrefs7();

    setState(() {});
  }

  void switchScreen(String screen) {
    setState(() {
      screenSwitch = screen;
      savedCompleted(completed, check, noOfLevel[0].finished, noOfLevel[1].finished, noOfLevel[2].finished);
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
      savedCompleted(completed, check, noOfLevel[0].finished, noOfLevel[1].finished, noOfLevel[2].finished);
    });
  }

  void exerciseWindow(int index) {
    setState(() {
      this.index = index;
      screenSwitch = 'exercise-screen';
      savedCompleted(completed, check, noOfLevel[0].finished, noOfLevel[1].finished, noOfLevel[2].finished);
    });
  }

  void goBackToGoals() {
    setState(() {
      screenSwitch = 'goal-screen';
      savedCompleted(completed, check, noOfLevel[0].finished, noOfLevel[1].finished, noOfLevel[2].finished);
    });
  }

  void increaseFinished(int x) {
    setState(() {
      if(noOfLevel[currentLevel].finished[x] < 2){
        noOfLevel[currentLevel].finished[x]++;
      }
      savedCompleted(completed, check, noOfLevel[0].finished, noOfLevel[1].finished, noOfLevel[2].finished);
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
      savedCompleted(completed, check, noOfLevel[0].finished, noOfLevel[1].finished, noOfLevel[2].finished);
    });
  }

  void waiting() {
      Timer(const Duration(seconds: 5), () {
        setState(() {
          levels[currentLevel].finished = [0,0,0,0,0,0,0,0,0,0];
        });
      });
  }

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