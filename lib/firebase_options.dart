// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return FirebaseOptions(
        apiKey: "AIzaSyDeluhdwsElI1OmWFjxNscLBKmRJcviFWI",
        authDomain: "bus-payment-2.firebaseapp.com",
        projectId: "bus-payment-2",
        storageBucket: "bus-payment-2.firebasestorage.app",
        messagingSenderId: "50019966109",
        appId: "1:50019966109:web:72895f3fdff1183520c874",
        measurementId: "G-EEQYZL2FK2",
      );
    }
    throw UnsupportedError('DefaultFirebaseOptions not set for this platform.');
  }
}