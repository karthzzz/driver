import 'package:flutter/material.dart';

class AddressInformationBox extends StatelessWidget {
  final String address;
  final String city;
  final String country;
  final String phone;
  final String notes;

  const AddressInformationBox(
      {super.key,
      required this.address,
      required this.city,
      required this.country,
      required this.phone,
      required this.notes});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Table(
            border:
                const TableBorder(horizontalInside: BorderSide(color: Colors.black)),
            children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Address',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.black.withOpacity(0.5))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    address,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("City",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.black.withOpacity(0.5))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    city,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Country',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.black.withOpacity(0.5))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    country,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Phone No',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.black.withOpacity(0.5))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    phone,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Notes',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.black.withOpacity(0.5))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    notes,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ]),
            ],
          )
        ],
      ),
    );
  }
}
