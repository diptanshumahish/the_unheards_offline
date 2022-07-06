import 'package:flutter/material.dart';
import 'package:the_unheards_offline/screens/screens.dart';

import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Unheards Offline',
      home: HomePage(),
    );
  }
}
