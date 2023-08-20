import 'package:driver/data/color_and_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DeliveryDetail extends StatelessWidget {
  const DeliveryDetail(
      {super.key,
      required this.header,
      required this.address,
      required this.location});

  final String header;
  final String address;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          thickness: 1,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            header,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: driverColor , fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            address,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                 
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            location,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!.copyWith(fontWeight: FontWeight.bold)
                 
          ),
        ),
         
      ],
    );
  }
}
