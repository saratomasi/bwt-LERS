import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:project/providers/dataprovider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ChangeNotifierProvider(
                create: (context) => DataProvider(),
                child:
                    Consumer<DataProvider>(builder: (context, provider, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      //provider.fetchData(provider.showDate.subtract(const Duration(days: 7)));
                      await provider.fetchData(provider.showDate);
                      provider.getLevel();
                      final sp = await SharedPreferences.getInstance();
                      print(sp.getString('level'));
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (!_isLoading) Text('Sync your device'),
                        if (_isLoading) 
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator()
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                _toLogin(context);
              },
              child: Text('Log out'),
            ),
            // AspectRatio(
            //   aspectRatio: 16/9,
            //   child: Consumer<DataProvider>(builder: (context, provider, child) {
            //   if (provider.heartRates.isEmpty) {
            //           return const CircularProgressIndicator.adaptive();
            //         }
            //         return Text('HeartRate obtained') ;
            //   }
            // )
            // ),
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

// heart_rate DONE
// calories NO
// sleep NO
// distance
// resting_heart_rate
// steps
// exercise ??