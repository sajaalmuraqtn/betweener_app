import 'dart:convert';

import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/follow_model.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> addFollow(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user;
  http.Response response;
  if (prefs.containsKey('user')) {
    user = userFromJson(prefs.getString('user')!);
    http.Response response = await http.post(
      Uri.parse("$followUrl"),
      headers: {'Authorization': 'Bearer ${user.token}'},
      body: {"followee_id": "$id"},
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
  return false;
}

Future<bool> isFollowedUserBefore(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (!prefs.containsKey('user')) {
    return false;
  }

  final user = userFromJson(prefs.getString('user')!);

  final response = await http.get(
    Uri.parse(followUrl),
    headers: {'Authorization': 'Bearer ${user.token}'},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonMap = jsonDecode(response.body);

     final List<dynamic> followingList = jsonMap["following"] ?? [];

     final List<UserClass> followingUsers =
        followingList.map((u) => UserClass.fromJson(u)).toList();

    //   البحث إذا كان المستخدم موجود ضمنهم
    final bool isFollowed = followingUsers.any((u) => u.id == id);
    return isFollowed;

  } else {
    throw Exception("Failed to fetch following list (status ${response.statusCode})");
  }
}

Future<FollowModel> getFollowInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (!prefs.containsKey('user')) {
    return Future.error("User not found");
  }

  final user = userFromJson(prefs.getString('user')!);

  final response = await http.get(
    Uri.parse(followUrl),
    headers: {'Authorization': 'Bearer ${user.token}'},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);

     return FollowModel.fromJson(data);
  } else {
    return Future.error(
      "Failed to get follow info (status ${response.statusCode})",
    );
  }
}
