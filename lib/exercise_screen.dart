import 'package:fitness_tracker/goal_con.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseScreen extends StatefulWidget{
  const ExerciseScreen(this.noOfLevel, this.index, this.goBack, this.increaseFinished ,{super.key});

  final GoalCon noOfLevel;
  final int index;
  final void Function () goBack;
  final void Function (int x) increaseFinished;

  @override
  State<ExerciseScreen> createState(){
    return _ExerciseScreenState();
  }
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Text(
            widget.noOfLevel.text[widget.index],
            style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 30,
                  ),
            textAlign: TextAlign.center,
          ),
          Image.asset(
            widget.noOfLevel.images[widget.index],
            width: 250,
            ),
          const SizedBox(height: 20,),
          Text(
            widget.noOfLevel.des[widget.index],
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 20
            ),
            textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20,),
            Text(
                'Complete 2 sets of 10 reps.',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 54, 244, 60)
                ),
              ),
            if(widget.noOfLevel.finished[widget.index] > 0)
              Text(
                'Rest for 30 seconds then continue.',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 218, 231, 38)
                ),
                ),

            ElevatedButton(
              onPressed: (){
                widget.increaseFinished(widget.index);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: const LinearBorder()
              ),
              child: Text(
                '(${widget.noOfLevel.finished[widget.index]} / 2)',
                style: const TextStyle(
                  color: Colors.white
                ),
                ),
              ),

            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                widget.goBack();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: const LinearBorder()
              ),
              child: const Text(
                'go back to goals',
                style: TextStyle(
                  color: Colors.white
                ),
                ),
              ),
        ],
      ),
    );
  }
}