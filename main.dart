import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(EduRideApp());
}

class EduRideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "EduRide",
      theme: ThemeData(fontFamily: 'Roboto'),
      home: HomeScreen(),
    );
  }
}
