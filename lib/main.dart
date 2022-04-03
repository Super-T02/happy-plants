// Firebase
import 'package:happy_plants/screens/home/tabs/garden/new_garden.dart';
import 'package:happy_plants/screens/wrapper.dart';
import 'package:happy_plants/services/authentication.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

// Flutter
import 'package:flutter/material.dart';
import 'package:happy_plants/shared/utilities/theme.dart';
import 'package:google_fonts/google_fonts.dart';

/// Start the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

/// Main (root) widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Happy Plants',
        themeMode: ThemeMode.system,
        theme: MyAppTheme.lightTheme,
        darkTheme: MyAppTheme.darkTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          '/newGarden': (context) => const NewGarden(),
        },
      ),
    );
  }
}

