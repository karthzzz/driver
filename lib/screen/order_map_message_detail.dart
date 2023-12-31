import 'dart:math';

import 'package:driver/backend/urls_from_data.dart';
import 'package:driver/data/color_and_placeholder.dart';
import 'package:driver/widget/order_information.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderMapMessageDetail extends StatefulWidget {
  OrderMapMessageDetail(
      {super.key,
      required this.header,
      required this.address,
      required this.location,
      required this.details});

  final Map details;
  final String header;
  final String address;
  final String location;

  @override
  State<OrderMapMessageDetail> createState() => _OrderMapMessageDetailState();
}

class _OrderMapMessageDetailState extends State<OrderMapMessageDetail> {
  bool isTap = false;
  // LatLng randomLocation = _getRandomLocation();

  Future<void> launchMap() async {
    String address = "${widget.address}, ${widget.location}";
    String mapsUrl = "https://www.google.com/maps/search/?api=1&query=$address";

    if (await canLaunch(mapsUrl)) {
      await launch(mapsUrl);
    } else {
      throw 'Could not launch $mapsUrl';
    }
  }

  void showSnack(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 2,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: driverColor,
        content: Text(
          message,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )));
  }

  // static LatLng _getRandomLocation() {
  //   final random = Random();
  //   final double lat = 16.3093 + random.nextDouble() * 0.05;
  //   final double lng = 80.4365 + random.nextDouble() * 0.05;
  //   return LatLng(lat, lng);
  // }

  List<String> latLongId = [];

  void getlatitudeAndLongitude() {
    setState(() {
      latLongId = retrieveLongAndLatitudes();
    });
  }

  void trackLocation() {
    getlatitudeAndLongitude();
    Future.delayed(Duration(seconds: 1));
    final mapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=${latLongId[0]},${latLongId[1]}';
    launch(mapsUrl);
  }

  int index = 0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: Colors.black)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => OrderInformation(
                        details: widget.details,
                      ))),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  widget.header,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: driverColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(widget.address,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(widget.location,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  style: ButtonStyle(
                      fixedSize:
                          const MaterialStatePropertyAll(Size.fromWidth(150)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.black))),
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 24, 34, 223)),
                      elevation: const MaterialStatePropertyAll(5),
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.all(8),
                      )),
                  onPressed: () {
                    showSnack("Calling customer");
                  },
                  icon: const Icon(
                    Icons.phone,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: Text(
                    'CALL',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Card(
                  borderOnForeground: true,
                  elevation: 5,
                  color: strings[index] == "STARTED"
                      ? Colors.yellow
                      : strings[index] == 'MAP'
                          ? Colors.green
                          : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  surfaceTintColor: isTap ? Colors.yellow : Colors.white,
                  child: TextButton(
                    onPressed: () {
                      if (strings[index] != 'MAP') {
                        setState(() {
                          index = index + 1;
                        });
                      }

                      if (strings[index] == 'MAP') {
                        count++;
                        if (count == 2) {
                          launchMap();
                        }
                      }
                    },
                    style: ButtonStyle(
                      fixedSize:
                          const MaterialStatePropertyAll(Size.fromWidth(150)),
                      elevation: MaterialStateProperty.all(10),
                      animationDuration: const Duration(milliseconds: 500),
                    ),
                    child: Row(
                      children: [
                        if (index == 0)
                          Image.asset("assets/Icons/Vector (13).jpg")
                        else
                          const SizedBox(
                            width: 10,
                          ),
                        Text(
                          strings[index],
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
