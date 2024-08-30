import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

  Widget getText(String tx){
    return Text(
      tx,
      style: GoogleFonts.lato(
        fontSize: 22,
        color: Colors.white,
      ),
      textAlign: TextAlign.left,
      textWidthBasis: TextWidthBasis.parent,
    );
  }

  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Instructions',
                style: GoogleFonts.aDLaMDisplay(
                  fontSize: 40,
                  color: Colors.white,
                ),
                ),
            ),
            const SizedBox(height: 25,),
            getText('-The 30 bodyweight moves in this app can be scaled for beginner, intermediate, and advanced exercisers (levels), so start where you feel ready and progress from there.'),
            const SizedBox(height: 20,),
            getText('-All these exercises can be made in home.'),
            const SizedBox(height: 20,),
            getText('-Warming up helps prepare your body for exercise by gradually increasing your heart rate and circulation. This will loosen your joints and increase blood flow to your muscles.'),
            const SizedBox(height: 20,),
            getText('-Start slow to Gradually increase the intensity and duration of your workouts to prevent overtraining and injuries.'),
            const SizedBox(height: 20,),
            getText("-Don't miss to take a break after each exercise, take at least 30 seconds."),
            const SizedBox(height: 20,),
            getText("-Maintaining proper form is crucial to avoid injuries and ensure you're effectively targeting the intended muscles."),
            const SizedBox(height: 150,),
         ],
        ),
      ),
    );
  }
}