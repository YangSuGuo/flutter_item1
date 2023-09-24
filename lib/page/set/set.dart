import 'package:flutter/material.dart';

class settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Settings = setListTile();
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 250, 250, 250), body: Settings);
  }

  Widget setListTile() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 20),
      ListTile(
        tileColor: Colors.white,
        leading: Icon(Icons.arrow_forward_ios),
        trailing: Icon(Icons.arrow_forward_ios),
        title: Text('账号信息'),
      )
    ]);
  }
}
