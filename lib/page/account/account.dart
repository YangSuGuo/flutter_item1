import 'package:flutter/material.dart';

class account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Text(
          "user",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
