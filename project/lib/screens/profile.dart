import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
            ChangeNotifierProvider(
              create: (context) => DataProvider(),
              child:
                  Consumer<DataProvider>(builder: (context, provider, child) {
                return ElevatedButton(
                  onPressed: () async{
                    //provider.fetchData(provider.showDate.subtract(const Duration(days: 7)));
                    await provider.fetchData(provider.showDate);
                    provider.getLevel() ;
                    final sp = await SharedPreferences.getInstance() ;
                    print(sp.getString('level')) ;

                  },
                  child: Text('Sync your device'),
                );
              }),
            ),
            ElevatedButton(
              onPressed: () async {
                _toLogin(context);
              },
              child: Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}

_toLogin(BuildContext context) async {
  final sp = await SharedPreferences.getInstance();
  await sp.clear();
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: ((context) => LoginPage())));
}

// heart_rate
// calories
// sleep
// distance
// resting_heart_rate
// steps
// exercise