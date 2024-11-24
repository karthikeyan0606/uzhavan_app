import 'package:flutter/material.dart';
import 'package:uzhavan_app/files/home/home.dart';

void main(){
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal
      ),
      home: Home(),
    );
  }
}





