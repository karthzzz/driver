import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:driver/data/color_and_placeholder.dart';
import 'package:driver/widget/driver_main_screen.dart';
import 'package:flutter/material.dart';

final kShemeColor =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 76, 175, 158));

void App(ConnectivityResult connectivityResult) async {
  if (connectivityResult == ConnectivityResult.mobile) {
    runApp(MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: kShemeColor),
        home: const DriverMainscreen()));
  } else if (connectivityResult == ConnectivityResult.wifi) {
    runApp(MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: kShemeColor),
        home: const DriverMainscreen()));
  } else if (connectivityResult == ConnectivityResult.none) {
    runApp(MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: kShemeColor),
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "No Connection",
                  style: TextStyle(
                    fontSize: 30,
                    color: driverColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Please Connect the network",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                Card(
                  borderOnForeground: true,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  surfaceTintColor: Colors.white,
                  child: TextButton.icon(
                    onPressed: () async{
                      final connectivityResult2 =
                          await(Connectivity().checkConnectivity());
                      App(connectivityResult2);
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(10),
                      animationDuration: const Duration(milliseconds: 500),
                    ),
                    icon: Icon(Icons.connect_without_contact),
                    label: const Text('Ok', style: TextStyle(fontSize: 15)),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final connectivityResult = await (Connectivity().checkConnectivity());
  App(connectivityResult);
}
