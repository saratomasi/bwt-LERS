import 'package:flutter/material.dart';
import'package:shared_preferences/shared_preferences.dart';
import 'package:project/screens/login.dart';
 
 class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                  _toLogin(context);
                },
              child: Text('Log out'),
              ),
          ],
        ),
      ),
    ) ;
  }
}
 
 
 
 _toLogin(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => LoginPage())));
 }
 //