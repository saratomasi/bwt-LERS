import 'package:flutter/material.dart' ;
import 'package:project/screens/questionnaire.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/utils/impact.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Impact impact = Impact();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: userController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                    hintText: 'Enter valid id'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              child: 
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  if(userController.text == Impact.username && passwordController.text == Impact.password){
                    final result = await impact.getAndStoreTokens(
                            userController.text, passwordController.text);
                        if (result == 200) {
                          final sp = await SharedPreferences.getInstance();
                          await sp.setString('username', userController.text);
                          await sp.setString('password', passwordController.text);
                          Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Questionnaire()));
                          }
                  }else{
                    ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('Wrong email/password')));
                  }
                },
                child: Text(
                  'Login',
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}