//Package imports
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/espaceEtudiant/meet/lib/screens/home_screen.dart';

//File imports

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Meet',
      theme: ThemeData(
          primaryColor: Colors.grey[900],
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.blueAccent),
                  foregroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.white)))),
      home: const HomeScreen(),
    );
  }
}
