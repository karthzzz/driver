import 'package:driver/widget/driver_main_screen.dart';
import 'package:flutter/material.dart';

final kShemeColor =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 76, 175, 158));
void main() {
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true, colorScheme: kShemeColor),
    home:  DriverMainscreen()
  ));
}
 
