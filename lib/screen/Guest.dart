import 'package:flutter/material.dart';
import 'package:leadeetuto/screen/guest/Auth.dart';
import 'package:leadeetuto/screen/guest/Password.dart';
import 'package:leadeetuto/screen/guest/Term.dart';

class GuestScreen extends StatefulWidget {
  @override
  _GuestScreenState createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  List<Widget> _widgets = [];
  int _indexSelected = 0;

  @override
  void initState() {
    super.initState();

    _widgets.addAll([
      AuthScreen(
        onChangedStep: (index) => setState(() => _indexSelected = index),
      ),
      TermScreen(
        onChangedStep: (index) => setState(() => _indexSelected = index),
      ),
      PasswordScreen(
        onChangedStep: (index) => setState(() => _indexSelected = index),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgets.elementAt(_indexSelected),
    );
  }
}
