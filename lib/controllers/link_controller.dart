import 'dart:convert';

import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/link_response_model.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<LinkElement>> getUserLinks() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (!prefs.containsKey('user')) {
    return Future.error("User not found");
  }

  final user = userFromJson(prefs.getString('user')!);

  final response = await http.get(
    Uri.parse(allLinksurl),
    headers: {'Authorization': 'Bearer ${user.token}'},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> linksMap = jsonDecode(response.body);
    final dynamic linksData = linksMap["links"];

    // ✅ إذا رجع السيرفر كائن واحد فقط
    if (linksData is Map<String, dynamic>) {
      return [LinkElement.fromJson(linksData)];
    }
    // ✅ إذا رجع السيرفر قائمة من الروابط
    else if (linksData is List) {
      return linksData.map((link) => LinkElement.fromJson(link)).toList();
    } else {
      return [];
    }
  } else {
    return Future.error("Failed to get links (status ${response.statusCode})");
  }
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

 Future<bool> editUserLink(Map<String, dynamic> linkdata,int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user;
  http.Response response;
  if (prefs.containsKey('user')) {
    user = userFromJson(prefs.getString('user')!);
    http.Response response = await http.put(
      Uri.parse("$allLinksurl/$id"),
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

 Future<bool> deleteUserLink(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user;
  http.Response response;
  if (prefs.containsKey('user')) {
    user = userFromJson(prefs.getString('user')!);
    http.Response response = await http.delete(
      Uri.parse("$allLinksurl/$id"),
      headers: {'Authorization': 'Bearer ${user.token}'},
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
  return false;
}
