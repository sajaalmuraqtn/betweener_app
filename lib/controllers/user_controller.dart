import 'dart:convert';

import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/views_features/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<User> getCurrentUser(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('user'))
    return userFromJson(prefs.getString('user')!);
  else {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error("not found");
}


Future<List<UserClass>> searchUserByName(Map<String, dynamic> searchdata) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (!prefs.containsKey('user')) {
    return Future.error("User not found");
  }

  final user = userFromJson(prefs.getString('user')!);

  final response = await http.post(
    Uri.parse(SearchUserByNameUrl),
    headers: {'Authorization': 'Bearer ${user.token}'},
    body: searchdata
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> usersFoundMap = jsonDecode(response.body);
    final dynamic usersData = usersFoundMap["user"];
    print("userdata->${usersFoundMap}");

    // ✅ إذا رجع السيرفر كائن واحد فقط
    if (usersData is Map<String, dynamic>) {
      return [UserClass.fromJson(usersData)];
    }
    // ✅ إذا رجع السيرفر قائمة من المستخدمين
    else if (usersData is List) {
      return usersData.map((user) => UserClass.fromJson(user)).toList();
    } else {
      return [];
    }
  } else {
    return Future.error("Failed to get links (status ${response.statusCode})");
  }
}

