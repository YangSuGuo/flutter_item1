import 'package:flutter/material.dart';
import 'package:item_1/page/home.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
  if(Platform.isAndroid){
    SystemUiOverlayStyle style = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home(),
    );
  }
}
