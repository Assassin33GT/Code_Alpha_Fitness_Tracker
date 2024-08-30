import 'package:fitness_tracker/goal_con.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen(this.noOfLevel, this.nameOfLevel, this.nameOfNextLevel, this.completed, this.changeLevel, this.exerciseWindow, {super.key});

  final GoalCon noOfLevel;
  final void Function () changeLevel;
  final String nameOfLevel;
  final String nameOfNextLevel;
  final void Function (int index) exerciseWindow;
  final int completed;

  Widget getButton(String tx ,int index){
    return
      ElevatedButton(
        onPressed: (){
          exerciseWindow(index);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 69, 68, 68)
        ),
        child: Text(
            tx,
            style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 20,
                  ),
                ),
        );
  }

  Widget getComplete(int f) {
    if(f < 2)
      {return const Text(
        'Not Completed',
        style: TextStyle(
          color: Colors.red
        ),
      );}
    else{
      return const Text(
        'Completed',
        style: TextStyle(
          color: Colors.green
      )
      );
    }
  }

  Widget getImage(String im){
    return
      Image.asset(
            im,
            width: 300,
            );
  }

  MaterialColor changeColor() {
    if(completed != 5) {
      return Colors.grey;
    }else{
      return  Colors.red;
    }
  }

  @override
  Widget build(context) {

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Text(
              nameOfLevel,
              style: GoogleFonts.saira(
                color: Colors.white,
                fontSize: 30,
              ),
              ),
            const Divider(
              color: Colors.grey,
              height: 20,
            ),
            Text(
              'Complete 2 sets of 10 reps of each exercise, with 30 seconds to 1 minute of rest between each move.',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '($completed/5)',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 20,),
            getImage(noOfLevel.images[0]),
            getComplete(noOfLevel.finished[0]),
            getButton(noOfLevel.text[0], 0),
            const SizedBox(height: 40,),
            getImage(noOfLevel.images[1]),
            getComplete(noOfLevel.finished[1]),
            getButton(noOfLevel.text[1], 1),
            const SizedBox(height: 40,),
            getImage(noOfLevel.images[2]),
            getComplete(noOfLevel.finished[2]),
            getButton(noOfLevel.text[2], 2),
            const SizedBox(height: 40,),
            getImage(noOfLevel.images[3]),
            getComplete(noOfLevel.finished[3]),
            getButton(noOfLevel.text[3], 3),
            const SizedBox(height: 40,),
            getImage(noOfLevel.images[4]),
            getComplete(noOfLevel.finished[4]),
            getButton(noOfLevel.text[4], 4),
            const SizedBox(height: 40,),
            getImage(noOfLevel.images[5]),
            getComplete(noOfLevel.finished[5]),
            getButton(noOfLevel.text[5], 5),
            const SizedBox(height: 40,),
            getImage(noOfLevel.images[6]),
            getComplete(noOfLevel.finished[6]),
            getButton(noOfLevel.text[6], 6),
            const SizedBox(height: 40,),
            getImage(noOfLevel.images[7]),
            getComplete(noOfLevel.finished[7]),
            getButton(noOfLevel.text[7], 7),
            const SizedBox(height: 40,),
            getImage(noOfLevel.images[8]),
            getComplete(noOfLevel.finished[8]),
            getButton(noOfLevel.text[8], 8),
            const SizedBox(height: 40,),
            getImage(noOfLevel.images[9]),
            getComplete(noOfLevel.finished[9]),
            getButton(noOfLevel.text[9], 9),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                if(completed == 5){
                  changeLevel();
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const LinearBorder(),
                backgroundColor: changeColor()
              )
             ,child: Text(
              nameOfNextLevel,
              style: const TextStyle(
                color: Colors.white
              ),
              )
            ),
          ],
        ),
      ),
    );
  }
}