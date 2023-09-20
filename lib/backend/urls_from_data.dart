import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> driverOrdersDashBoard() async {
  var url = Uri.parse(
      "http://38.89.140.3:9999/driver_orders_dashboard?M_Driver_ID=1000011");
  var json1 = await http.get(url);
  return jsonDecode(json1.body);
}

Future<Map<String, String>> retrieveCitiesAndCount() async {
  var listOfConsigneeCity = [];
  Map<String, String> mapOfTheConsigneeCityAndCount = {};
  List<String> tempConsigneeCity = [];
  var url = Uri.parse(
      "http://38.89.140.3:9999/driver_orders_list_dashboard?M_Driver_ID=1000011&CityName=&OrderNo=");
  var json1 = await http.get(url);
  Map<String, dynamic> jsonDecodedMap = jsonDecode(json1.body);
  List<dynamic> jsonAddressDetails = jsonDecodedMap["data"];
  for (var element in jsonAddressDetails) {
    listOfConsigneeCity.add(element['ConsigneeCity']);
  }
  listOfConsigneeCity.sort();
  for (var i = 0; i < listOfConsigneeCity.length; i++) {
    if (tempConsigneeCity.contains(listOfConsigneeCity[i]) == false) {
      tempConsigneeCity.add(listOfConsigneeCity[i]);
    }
  }
  for (var i = 0; i < tempConsigneeCity.length; i++) {
    var array =
        listOfConsigneeCity.where((element) => tempConsigneeCity[i] == element);
    mapOfTheConsigneeCityAndCount
        .addAll({tempConsigneeCity[i]: array.length.toString()});
  }
  return mapOfTheConsigneeCityAndCount;
}

Future<List<Map>> retreiveCitieWiseOrders(String cities) async {
  var url = Uri.parse(
      'http://38.89.140.3:9999/driver_orders_list_dashboard?M_Driver_ID=1000011&CityName=&OrderNo=');
  var json1 = await http.get(url);
  Map<String, dynamic> jsonDecodedMap = jsonDecode(json1.body);
  List<dynamic> jsonAddressDetails = jsonDecodedMap["data"];
  var array = [
    jsonAddressDetails.where((element) => element['ConsigneeCity'] == cities)
  ];
  List<Map> arrayOfMap = [];
  for (var i = 0; i < array.length; i++) {
    array[i].forEach((element) {
      arrayOfMap.add({
        "OrderNo": element["OrderNo"],
        "ConsigneeAddress": element["ConsigneeAddress"],
        "Country": element["CountryName"],
        "CustomerName": element["CustomerName"],
        "C_Order_ID": element["C_Order_ID"],
        "PaymentMethod": element["PaymentMethod"],
        "ConsigneeCity": element["ConsigneeCity"],
        "OrderAmount": element["OrderAmount"],
        "Phone": "123456789"
      });
    });
  }
  return arrayOfMap;
}

List<String> retrieveLongAndLatitudes() {
  List<String> latLongId = [];
  final url =
      'http://38.89.140.3:9999/confirm_consignee_location_url?TrackingNo=773218599939&LocationURL=16.307399859708624,%2080.43943722679539';

  final uri = Uri.parse(url);
  print(uri);

  // Extracting the latitude and longitude
  final locationURL = uri.queryParameters['LocationURL'];

  final List<String> latLng = locationURL!.split(',');
  final latitude = double.parse(latLng[0]);
  final longitude = double.parse(latLng[1]);

  // Extracting the order ID
  final orderID = uri.queryParameters['TrackingNo'];

  // Printing the results
  latLongId.add(latitude.toString());
  latLongId.add(longitude.toString());
  latLongId.add(orderID.toString());

  return latLongId;
}

Map<String, String> sortItems(Map<String, String> citiesAndCount) {
  var citiCountList = citiesAndCount.entries.toList();
  citiCountList.sort(
    (a, b) => int.parse(a.value).compareTo(
      int.parse(b.value),
    ),
  );
  Map<String, String> tempCitiAndCount = {};
  for (var element in citiCountList) {
    tempCitiAndCount.addAll({element.key: element.value});
  }
  print(tempCitiAndCount);
  return tempCitiAndCount;
}
