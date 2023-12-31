import 'package:driver/screen/order_map_message_detail.dart';
import 'package:flutter/material.dart';

class ResultDetail extends StatelessWidget {
  const ResultDetail({super.key, required this.orderDetails, required this.header  });

  final List<Map> orderDetails;
  final String header;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 30,
                    ),
                    Text(
                       header,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
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
                const SizedBox(
                  height: 4,
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color.fromARGB(156, 231, 223, 223),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 4,
                        ),
                        Text(orderDetails.length.toString()),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text('Result found'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ...orderDetails.map((e) => Column(
                      children: [
                        OrderMapMessageDetail(
                          details: e,
                          header: e["OrderNo"],
                          address: e["ConsigneeAddress"],
                          location: e["Country"],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
