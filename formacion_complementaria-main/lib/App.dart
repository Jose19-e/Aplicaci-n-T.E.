import 'package:flutter/material.dart';
import 'package:actividades_complementarias/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super (key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FES Aragon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Login(title: 'Flutter Demo'),
    );
  }
}