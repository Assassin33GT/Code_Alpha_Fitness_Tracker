import 'package:fitness_tracker/goal_con.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen(this.levels, this.completed, this.resetLevels, this.goalsScreen,{super.key});

  final List<GoalCon> levels;
  final void Function() goalsScreen;
  final List<int> completed;
  final void Function() resetLevels;
  @override
  Widget build(context) {
    Text getText(String tx){
      return Text(
                tx,
                style: GoogleFonts.sansita(
                  color: Colors.white,
                  fontSize: 40,
                ),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          getText('Level 1'),
          getText('${completed[0]}/5'),
          const SizedBox(height: 20,),
          getText('Level 2'),
          getText('${completed[1]}/5'),
          const SizedBox(height: 20,),
          getText('Level 3'),
          getText('${completed[2]}/5'),
          const SizedBox(height: 40,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed:() {
                  goalsScreen();
                  },
                style: ElevatedButton.styleFrom(
                  shape: const LinearBorder(),
                  backgroundColor: Colors.red
                ),
                child: const Text(
                  'Goals',
                  style: TextStyle(
                    color: Colors.white
                  ),
                  )
                ),

              const SizedBox(width: 20,),

              ElevatedButton(
                onPressed:() {
                resetLevels();
              },
              style: ElevatedButton.styleFrom(
                shape: const LinearBorder(),
                backgroundColor: Colors.red
              ),
              child: const Text(
                'Reset',
                style: TextStyle(
                  color: Colors.white
                ),
                )
              ),
              ],
            ),
        ],
      ),
    );
  }
}