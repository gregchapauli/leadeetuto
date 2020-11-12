import 'package:flutter/material.dart';
import 'package:leadeetuto/models/UserModel.dart';
import 'package:leadeetuto/screen/dashboard/Home.dart';
import 'package:leadeetuto/screen/guest/Auth.dart';
import 'package:leadeetuto/screen/guest/Password.dart';
import 'package:leadeetuto/screen/guest/Term.dart';
import 'package:leadeetuto/screen/services/CommonService.dart';
import 'package:leadeetuto/screen/services/UserService.dart';

class GuestScreen extends StatefulWidget {
  @override
  _GuestScreenState createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  CommonService _commonService = CommonService();
  UserService _userService = UserService();

  List<Widget> _widgets = [];
  int _indexSelected = 0;

  String _email;

  @override
  void initState() {
    super.initState();

    _commonService.terms.then(
      (terms) => setState(
        () => _widgets.addAll([
          AuthScreen(
            onChangedStep: (index, value) => setState(() {
              _indexSelected = index;
              _email = value;
            }),
          ),
          TermScreen(
            terms: terms,
            onChangedStep: (index) => setState(() => _indexSelected = index),
          ),
          PasswordScreen(
            onChangedStep: (index, value) => setState(() {
              if (index != null) {
                _indexSelected = index;
              }

              if (value != null) {
                _userService
                    .auth(UserModel(
                  email: _email,
                  password: value,
                ))
                    .then(
                  (value) {
                    if (value.uid != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }
                  },
                );
              }
            }),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgets.length == 0
          ? SafeArea(
              child: Scaffold(
                body: Center(
                  child: Text('Loading...'),
                ),
              ),
            )
          : _widgets.elementAt(_indexSelected),
    );
  }
}
