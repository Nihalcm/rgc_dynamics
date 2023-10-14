import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rgc_dynamics/screens/dashboard/dashboard.dart';
import 'package:rgc_dynamics/screens/model/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelWidgets>(create: (_) => ModelWidgets())
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xFF002642),
            focusColor: Color(0xFF00A699),
            textTheme: TextTheme(
              headlineMedium: GoogleFonts.nunito(
                  color: Color(0xFF002642),
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
              headlineLarge: GoogleFonts.nunito(
                  color: Color(0xFF002642),
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
              titleMedium: GoogleFonts.nunito(
                  color: Color(0xFF00A699),
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            )),
        home: Dashboard(),
      ),
    );
  }
}
