import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rgc_dynamics/screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(
        primaryColor: Color(0xFF002642),
        focusColor: Color(0xFF00A699),
        textTheme: TextTheme(headlineMedium:GoogleFonts.nunito(color:Color(0xFF002642),fontWeight:FontWeight.w700,fontSize: 16),
            headlineLarge:GoogleFonts.nunito(color:Color(0xFF002642),fontWeight:FontWeight.w700,fontSize: 20),
            titleMedium:GoogleFonts.nunito(color: Color(0xFF00A699),fontWeight:FontWeight.w600,fontSize: 16),) ),
    home: Dashboard(),
    );
  }
}
