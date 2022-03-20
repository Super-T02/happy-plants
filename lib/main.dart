import 'package:flutter/material.dart';
import 'screens/overview.dart';

void main() {
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
      ),
      home: const Overview(title: 'Happy Plants'),
    );
  }
}
