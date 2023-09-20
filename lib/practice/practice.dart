import 'dart:convert';
import 'package:http/http.dart' as http;

void main(List<String> args)async {
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
  print(mapOfTheConsigneeCityAndCount);
}
