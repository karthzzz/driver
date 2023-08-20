import 'package:driver/data/color_and_placeholder.dart';
import 'package:driver/screen/delivery_details.dart';
import 'package:driver/widget/result_detail.dart';
import 'package:flutter/material.dart';

class DeliveriesListBox extends StatefulWidget {
  DeliveriesListBox(
      {super.key, required this.townName, required this.count});
  final String townName;
  final String count;
   

  @override
  State<DeliveriesListBox> createState() => _DeliveriesListBoxState();
}

class _DeliveriesListBoxState extends State<DeliveriesListBox> {
  bool isOpen = false;
   List<List<String>>? orderDetails;  

   @override
  void initState() {
    orderDetails = widget.townName == "Guntur" ? orderGunturDetails : widget.townName == 'Gorantla' ? orderGorantlaDetails : widget.townName == 'Nallpadu' ? orderNallapaduDetails : widget.townName == 'Lam' ? orderLamDetails : widget.townName == 'LakshmiPuram' ? orderLakshmiPuramCancelled :[[]];
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
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
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ResultDetail(
                        orderDetails:  orderDetails!,
                        header: widget.townName,
                      ),
                    ),
                  ),
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
                    if (widget.townName == "Guntur")
                      ...orderGunturDetails.map(
                        (item) => DeliveryDetail(
                          header: item[0],
                          address: item[1],
                          location: item[2],
                        ),
                      )
                    else if (widget.townName == "Nallpadu")
                      ...orderNallapaduDetails.map(
                        (item) => DeliveryDetail(
                          header: item[0],
                          address: item[1],
                          location: item[2],
                        ),
                      )
                    else if (widget.townName == "Gorantla")
                      ...orderGorantlaDetails.map(
                        (item) => DeliveryDetail(
                          header: item[0],
                          address: item[1],
                          location: item[2],
                        ),
                      )
                    else if (widget.townName == "Lam")
                      ...orderLamDetails.map(
                        (item) => DeliveryDetail(
                          header: item[0],
                          address: item[1],
                          location: item[2],
                        ),
                      )
                    else if (widget.townName == "LakshmiPuram")
                      ...orderLakshmiPuramCancelled.map(
                        (item) => DeliveryDetail(
                          header: item[0],
                          address: item[1],
                          location: item[2],
                        ),
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
