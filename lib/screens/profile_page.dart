import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Profile",
        style:TextStyle(
          color: Colors.white)),
          backgroundColor:Colors.black,
          titleTextStyle: TextStyle(fontSize: 30),
          ),
      body: Center(
        child: Text(
          'This is Profile Page',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
