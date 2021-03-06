import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:service_provider_app/screen/homePage/home_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
            appId: '1:297855924061:ios:c6de2b69b03a5be8',
            apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
            projectId: 'flutter-firebase-plugins',
            messagingSenderId: '297855924061',
            databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
          )
        : FirebaseOptions(
            appId: '1:677049317592:android:9a044761966e3b4683bfad',
            apiKey: 'AIzaSyA49SytzlLV0LGn5Ayl_4ovjjdDVeyjdTk',
            messagingSenderId: '297855924061',
            projectId: 'flutter-firebase-plugins',
            databaseURL: 'https://warshatk-9fa8b-default-rtdb.firebaseio.com',
          ),
  );

  runApp(MaterialApp(
    title: 'Warshatk Provider',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: HomeScreen(),
  ));
}

