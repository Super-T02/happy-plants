// Firebase
import 'package:happy_plants/core/sign_in.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

// Flutter
import 'package:flutter/material.dart';
import 'core/structure.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Plants',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.robotoTextTheme(),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 7, 232, 89),
        )
      ),
      // home: const Overview(title: 'Happy Plants'),
      home: const SignIn(title: 'Happy Plants'),
    );
  }
}

