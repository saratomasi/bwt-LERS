import 'package:flutter/material.dart';
import'package:shared_preferences/shared_preferences.dart';
import 'package:project/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:project/providers/dataprovider.dart';
 
 class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                  _toLogin(context);
                },
              child: Text('Log out'),
              ),
              Consumer<DataProvider>(builder: (context, provider, child) {
              return ElevatedButton(
                onPressed: () {
                  //provider.getDataOfDay(provider.showDate.subtract(const Duration(days: 7)));
                  provider.getDataOfDay(provider.showDate);
                  //print(provider.heartRates) ; 
                }, 
                child: Text('Sync your device'),
                ) ;
              }
              ),
          ],
        ),
      ),
    ) ;
  }
}
 // TODO INSERIRE IL PROVIDER NEL MAIN E FIXARE IL PROVIDER IN QUESTA PAGINA
 
 
 _toLogin(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => LoginPage())));
 }
 //