import 'package:flutter/material.dart';
import 'package:leadeetuto/screen/Guest.dart';
import 'package:leadeetuto/screen/services/UserService.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: RaisedButton(
            onPressed: () async {
              await _userService.logout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => GuestScreen(),
                ),
                (route) => false,
              );
            },
            child: Text('logout'),
          ),
        ),
      ),
    );
  }
}
