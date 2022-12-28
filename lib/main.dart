import 'package:flutter/material.dart';
import './plan_provider.dart';
import './views/plan_creator_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(PlanProvider(child: const MasterPlanApp()));
}

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Babbista',
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: GoogleFonts.getFont('Poppins').fontFamily),
      debugShowCheckedModeBanner: false,
      home: const PlanCreatorScreen(),
    );
  }
}
