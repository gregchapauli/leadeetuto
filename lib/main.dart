import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leadeetuto/screen/guest/Auth.dart';
import 'package:leadeetuto/screen/Guest.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leadee',
      home: GuestScreen(),
    );
  }
}
