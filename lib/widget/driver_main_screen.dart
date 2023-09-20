import 'package:driver/backend/urls_from_data.dart';
import 'package:driver/data/color_and_placeholder.dart';
import 'package:driver/screen/deliveries_list_box.dart';
import 'package:flutter/material.dart';

class DriverMainscreen extends StatefulWidget {
  const DriverMainscreen({super.key});

  @override
  State<DriverMainscreen> createState() => _DriverMainscreenState();
}

class _DriverMainscreenState extends State<DriverMainscreen> {
  final _scanController = TextEditingController();
  int? tab;
  Map<String, dynamic> driverDashBoard = {};
  Map<String, String> driverCitiesAndCount = {};
  Map<String, String> driverCitiesAndCountSortvalue = {};

  @override
  void initState() {
    tab = 0;
    retreievePendingDeliveriedCanceled();
    super.initState();
  }

  void retreievePendingDeliveriedCanceled() async {
    await driverOrdersDashBoard().then((value) {
      setState(() {
        driverDashBoard = value;
      });
    });
    await retrieveCitiesAndCount().then((value) {
      setState(() {
        driverCitiesAndCount = value;
      });
    });
  }

  void showSnack(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 2,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: driverColor,
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void showSort() {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                splashColor: driverColor,
                highlightColor: driverColor,
                overlayColor: MaterialStatePropertyAll(driverColor),
                hoverColor: driverColor,
                focusColor: driverColor,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Image.asset("assets/Icons/screen_1_sort.jpg"),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "SORT BY DISTANCE",
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.black.withOpacity(0.4),
                onTap: () {
                  setState(() {
                    driverCitiesAndCount = sortItems(driverCitiesAndCount);
                  });
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Image.asset("assets/Icons/g.jpg"),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "SORT BY NO OF ORDERS",
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: driverColor,
        toolbarHeight: 80,
        title: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  driverDashBoard["TOTAL_OPEN_ORDERS"].toString() == "null"
                      ? "0"
                      : driverDashBoard["TOTAL_OPEN_ORDERS"].toString(),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Deliveries",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                const Spacer(),
                InkWell(
                    onTap: () {
                      showSnack("This is the profile");
                    },
                    child: Image.asset("assets/Icons/Rectangle 1 (2).png"))
              ],
            )
          ],
        ),
      ),
      body: driverDashBoard.length == 0
          ? Center(
              child: CircularProgressIndicator(
                color: driverColor,
              ),
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        borderOnForeground: true,
                        shadowColor: Colors.black,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        surfaceTintColor: Colors.white,
                        child: TextField(
                          controller: _scanController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/Icons/qr_code.jpg"),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "QUICK SCAN ORDER",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black.withOpacity(0.5)),
                                )
                              ],
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                tab = 0;
                              });
                            },
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        side: const BorderSide(
                                            color: Colors.black))),
                                elevation: const MaterialStatePropertyAll(10),
                                alignment: Alignment.center,
                                backgroundColor: MaterialStatePropertyAll(
                                    tab == 0 ? driverColor : Colors.white)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 5),
                              child: Column(
                                children: [
                                  Text(
                                    "Pending",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: tab == 0
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    child: Text(
                                      (driverDashBoard["TOTAL_OPEN_ORDERS"] -
                                              driverDashBoard[
                                                  "TOTAL_DELIVERED_ORDERS_TODAY"])
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                tab = 1;
                              });
                            },
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        side: const BorderSide(
                                            color: Colors.black))),
                                elevation: const MaterialStatePropertyAll(10),
                                alignment: Alignment.center,
                                backgroundColor: MaterialStatePropertyAll(
                                    tab == 1 ? driverColor : Colors.white)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 5),
                              child: Column(
                                children: [
                                  Text(
                                    "Delivered",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: tab == 1
                                                ? Colors.white
                                                : Colors.black),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    child: Text(
                                      driverDashBoard[
                                              "TOTAL_DELIVERED_ORDERS_TODAY"]
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: driverColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                tab = 2;
                              });
                            },
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        side: const BorderSide(
                                            color: Colors.black))),
                                elevation: const MaterialStatePropertyAll(10),
                                alignment: Alignment.center,
                                backgroundColor: MaterialStatePropertyAll(
                                    tab == 2 ? driverColor : Colors.white)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 5),
                              child: Column(
                                children: [
                                  Text(
                                    "Canceled",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: tab == 2
                                                ? Colors.white
                                                : Colors.black),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    child: Text(
                                      driverDashBoard[
                                              "TOTAL_CANCELLED_ORDERS_TODAY"]
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Deliveries List",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () {
                              showSort();
                            },
                            style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              side: const MaterialStatePropertyAll(
                                BorderSide(color: Colors.black),
                              ),
                            ),
                            icon: Image.asset("assets/Icons/sort.jpg"),
                            label: const Text(
                              'Sort',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (tab == 0)
                        Column(
                          children: [
                            if (driverCitiesAndCount.length == 0)
                              CircularProgressIndicator(
                                color: driverColor,
                              ),
                            if (driverCitiesAndCount.length != 0)
                              ...driverCitiesAndCount.entries.map(
                                (e) => DeliveriesListBox(
                                  townName: e.key,
                                  count: e.value,
                                  key: GlobalKey(),
                                ),
                              )
                          ],
                        )
                      else if (tab == 1)
                        const Column(
                          children: [
                            // ...deliveryDetailsDelivered.map(
                            //   (e) => DeliveriesListBox(
                            //     townName: e[0],
                            //     count: e[1],
                            //     key: GlobalKey(),
                            //   ),
                            // )
                            Text("No Data")
                          ],
                        )
                      else if (tab == 2)
                        // ...deliveryCancelled.map(
                        //   (e) => DeliveriesListBox(
                        //     townName: e[0],
                        //     count: e[1],
                        //     key: GlobalKey(),
                        //   ),
                        // )
                        const Text("No Data")
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
