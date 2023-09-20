import 'package:driver/backend/urls_from_data.dart';
import 'package:driver/data/color_and_placeholder.dart';
import 'package:driver/screen/delivery_details.dart';
import 'package:driver/widget/result_detail.dart';
import 'package:flutter/material.dart';

class DeliveriesListBox extends StatefulWidget {
  DeliveriesListBox({super.key, required this.townName, required this.count});
  final String townName;
  final String count;

  @override
  State<DeliveriesListBox> createState() => _DeliveriesListBoxState();
}

class _DeliveriesListBoxState extends State<DeliveriesListBox> {
  bool isOpen = false;
  List<Map> listOfMapAddress = [];

  @override
  void initState() {
    super.initState();
  }

  void retrieveCities() async {
    await retreiveCitieWiseOrders(widget.townName).then((value) {
      setState(() {
        listOfMapAddress = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isOpen) {
      retrieveCities();
    }
    return Card(
      elevation: 4,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
        side: const BorderSide(color: Colors.black),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 30,
                ),
                GestureDetector(
                  onTap: () {
                    if(isOpen) {
                      Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ResultDetail(
                          orderDetails: listOfMapAddress,
                          header: widget.townName,
                        ),
                      ),
                    );
                    }
                  },
                  child: Text(
                    widget.townName,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: isOpen ? driverColor : Colors.black,
                        ),
                  ),
                ),
                const Spacer(),
                Text(
                  widget.count,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isOpen = isOpen == true ? false : true;
                    });
                  },
                  icon: isOpen
                      ? Icon(
                          Icons.keyboard_arrow_up_outlined,
                          size: 30,
                          color: driverColor,
                        )
                      : Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 30,
                          color: driverColor,
                        ),
                )
              ],
            ),
          ),
          isOpen
              ? Column(
                  children: [
                    if (listOfMapAddress.length != 0)
                      ...listOfMapAddress.map(
                        (e) => DeliveryDetail(
                          header: e["OrderNo"],
                          address: e["ConsigneeAddress"],
                          location: e["Country"],
                        ),
                      ),
                    if (listOfMapAddress.length == 0)
                      CircularProgressIndicator(
                        color: driverColor,
                      ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                )
              : const SizedBox(
                  height: 1,
                )
        ],
      ),
    );
  }
}
