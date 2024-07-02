import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:project/providers/dataprovider.dart';
import 'package:project/screens/questionnaire.dart';
import 'package:project/screens/homepage.dart'; // Ensure this import path is correct


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  String _nome = '';
  String _cognome = '';
  int _eta = 0;
  String _sede = '';
  String _frequenzaAllenamento = '';
  String _avatar = '';
  String _livelloProvvisorio = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = prefs.getString('nome') ?? '';
      _cognome = prefs.getString('cognome') ?? '';
      _eta = prefs.getInt('eta') ?? 0;
      _sede = prefs.getString('sede') ?? '';
      _frequenzaAllenamento = prefs.getString('frequenzaAllenamento') ?? '';
      _avatar = prefs.getString('avatar') ?? '';
      _livelloProvvisorio = prefs.getString('livelloProvvisorio') ?? ''; // Load provisional level
    });
  }

  Future<void> _clearProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('nome');
    await prefs.remove('cognome');
    await prefs.remove('eta');
    await prefs.remove('sede');
    await prefs.remove('frequenzaAllenamento');
    await prefs.remove('avatar');
    await prefs.remove('livelloProvvisorio'); // Remove provisional level
  }

  Future<void> _showEditProfileWarning() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('After modifying your profile, remember to resync your data.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _clearProfileData().then((_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Questionnaire()),
                  ).then((_) {
                    _loadProfileData();
                  });
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _editProfile() {
    _showEditProfileWarning();
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to log out? You will lose your questionnaire and level data.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Log Out'),
              onPressed: () {
                _logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_avatar.isNotEmpty)
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Image.asset(_avatar, width: 50, height: 50),
                          title: Text('$_nome $_cognome'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Age: $_eta'),
                              Text('Location: $_sede'),
                              Text('Exercise frequency: $_frequenzaAllenamento'),
                              Text('Provisional Level: $_livelloProvvisorio'), // Display provisional level
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: _editProfile,
                              child: Text('Edit Profile'),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChangeNotifierProvider(
                      create: (context) => DataProvider(),
                      child: Consumer<DataProvider>(builder: (context, provider, child) {
                        return ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
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
                                  child: CircularProgressIndicator(),
                                ),
                            ],
                          ),
                        );
                      }),
                    ),
                    ElevatedButton(
                      onPressed: _showLogoutDialog,
                      child: Text('Log out'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}