import 'dart:convert';

import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/link_response_model.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<LinkElement>> getUserLinks() async {
 
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user;
  http.Response response;
  if (prefs.containsKey('user')) {
    user = userFromJson(prefs.getString('user')!);
    http.Response response = await http.get(
      Uri.parse(allLinksurl),
      headers: {'Authorization': 'Bearer ${user.token}'},
    );
    Map<String, dynamic> linksMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(LinkElement.fromJson(linksMap["links"][1]).title);
      return linksMap["links"]
          .map((link) => LinkElement.fromJson(link))
          .toList()
          .cast<LinkElement>();
    }
    return Future.error("Failed to Get Links");
  }
  return Future.error("Failed to Get Links");
}

 Future<bool> addUserLink(Map<String, dynamic> linkdata) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user;
  http.Response response;
  if (prefs.containsKey('user')) {
    user = userFromJson(prefs.getString('user')!);
    http.Response response = await http.post(
      Uri.parse(allLinksurl),
      headers: {'Authorization': 'Bearer ${user.token}'},
      body: linkdata,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
  return false;
}
