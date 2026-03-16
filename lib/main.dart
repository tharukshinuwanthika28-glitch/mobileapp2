import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // import the options
import 'screens/payment_method_screen.dart';
import 'screens/payment_history_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // ✅ important for Web
  );
  runApp(BusPaymentApp());
}

class BusPaymentApp extends StatelessWidget {
  final Color darkBlue = Color(0xFF1A237E);
  final Color lightGrey = Color(0xFFF5F7F9);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bus Payment System",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: lightGrey,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: darkBlue,
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            color: darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          bodyMedium: TextStyle(
            color: darkBlue,
            fontSize: 16,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
      home: PaymentMethodScreen(),
    );
  }
}