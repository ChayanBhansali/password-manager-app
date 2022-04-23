import 'package:flutter/material.dart';
import 'package:su_task7/screens/home.dart';
import 'package:su_task7/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Home(),
  ));
}

