import 'package:flutter/material.dart';
import 'package:happy_plants/shared/utilities/MyAppTheme.dart';
import 'core/structure.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Plants',
      themeMode: ThemeMode.system,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      /*ThemeData(
        //primarySwatch: Colors.green,
        primaryColor: const Color.fromARGB(255, 7, 232, 89),
        textTheme: GoogleFonts.robotoTextTheme(),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 7, 232, 89),
        )
      ),*/
      home: const Structure(title: 'Happy Plants'),
    );
  }
}
