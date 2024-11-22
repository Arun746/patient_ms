// ignore_for_file: prefer_const_constructors

import 'package:patient_ms/screen/appointment.screen.dart';
import 'package:patient_ms/screen/home.screen.dart';
import 'package:patient_ms/Auth/screen/login.screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:patient_ms/screen/userselect.screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock the orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  get args => null;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color.fromARGB(0, 255, 255, 255)));
    return MaterialApp(
      title: 'Norvic Hospital',
      home: const LoginScreen(),
      routes: <String, WidgetBuilder>{
        '/Login': (BuildContext context) => const LoginScreen(),
        '/Home': (BuildContext context) => const Home(),
        '/SelectUser': (BuildContext context) => const SelectUser(),
        '/Appointment': (BuildContext context) => const Appointment(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
