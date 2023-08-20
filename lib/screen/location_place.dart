import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LocationPin {
  final double latitude;
  final double longitude;

  LocationPin(this.latitude, this.longitude);
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LatLng randomLocation = _getRandomLocation();

  static LatLng _getRandomLocation() {
    final random = Random();
    final double lat = 16.3093 + random.nextDouble() * 0.05;
    final double lng = 80.4365 + random.nextDouble() * 0.05;
    return LatLng(lat, lng);
  }

  void trackLocation() {
    final mapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=${randomLocation.latitude},${randomLocation.longitude}';
    launchUrlString(mapsUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Tracking App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Random Location: ${randomLocation.latitude}, ${randomLocation.longitude}',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: trackLocation,
              child: Text('Track Location on Google Maps'),
            ),
          ],
        ),
      ),
    );
  }
}
