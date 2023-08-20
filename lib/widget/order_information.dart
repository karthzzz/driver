import 'package:driver/data/color_and_placeholder.dart';
import 'package:driver/screen/address_information.dart';
import 'package:driver/screen/order_information_box.dart';
import 'package:flutter/material.dart';

class OrderInformation extends StatefulWidget {
  const OrderInformation({super.key});

  @override
  State<OrderInformation> createState() => _OrderInformationState();
}

class _OrderInformationState extends State<OrderInformation> {
  final _locationController = TextEditingController();
  final _productController = TextEditingController();
  String? _status;

  @override
  Widget build(BuildContext context) {
    print(_status);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order View",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10),
                        animationDuration: const Duration(milliseconds: 500),
                      ),
                      icon: Image.asset('assets/Icons/Vector (11).jpg'),
                      label: Text(
                        'Back',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: driverColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Change Status:",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white),
                      child: DropdownButtonFormField(
                          autovalidateMode: AutovalidateMode.always,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          elevation: 2,
                          value: _status,
                          decoration: InputDecoration(
                              labelText: "--SELECT--",
                              labelStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              focusColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: driverColor)),
                              fillColor: Colors.white),
                          items: changeStatus
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          changeStatusIcons[e].toString()),
                                      Text(e)
                                    ],
                                  )))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _status = value;
                            });
                          }),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: FilledButton(
                  style: ButtonStyle(
                      backgroundColor: _status.toString() != 'null'
                          ? MaterialStatePropertyAll(Colors.green)
                          : MaterialStatePropertyAll(
                              Color.fromARGB(255, 138, 130, 130)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {},
                  child: Text(
                    "Submit",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: _status.toString() != 'null'
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Order information",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: driverColor),
                  ),
                ],
              ),
            ),
            OrderInformationBox(
                header: '#0B95872905817',
                sender: "Demo Account",
                invoiceNo: 123.toString(),
                customerName: "Gs store",
                payment: "Kuwait",
                amount: 1000.toString()),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Address information",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: driverColor),
                  ),
                ],
              ),
            ),
            const AddressInformationBox(
              address: "Fhatimapuram",
              city: "Guntur",
              country: "India",
              phone: "700000008",
              notes: "Test Order",
            )
          ],
        ),
      )),
    );
  }
}
