// Firebase
import 'package:happy_plants/screens/authenticate/sign_in.dart';
import 'package:happy_plants/screens/wrapper.dart';
import 'package:happy_plants/services/authentication.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

// Flutter
import 'package:flutter/material.dart';
import 'screens/home/home.dart';
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
    return StreamProvider<CustomUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Happy Plants',
        theme: ThemeData(
            primarySwatch: Colors.green,
            textTheme: GoogleFonts.robotoTextTheme(),
            iconTheme: const IconThemeData(
              color: Color.fromARGB(255, 7, 232, 89),
            )
        ),
        // home: const Home(),
        home: const Wrapper(),
      ),
    );
  }
}

