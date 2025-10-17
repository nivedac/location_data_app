import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Settings",
        style:TextStyle(color: Colors.white)),
        backgroundColor:Colors.black,
        titleTextStyle: TextStyle(fontSize: 30),
        ),
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'This is Settings Page',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
