import 'dart:convert';

import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:http/http.dart' as http;

Future<User> login(Map<String, dynamic> body) async {
  //body-->>  userclass (name,password,..) and token

  http.Response response = await http.post(Uri.parse(loginURL), body: body);

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
    //jsonDecode بواسطة  json ل  string  لهيك رح احولو من  string بكون  body ال  
    //user من ال  object اللي هو  modelل  json هون رح احول من  
  } else {
    return Future.error("Failed to login");
  }
}

Future<User> register(Map<String, dynamic> body) async {
  //body-->>  userclass (name,password,..) and token
  
  http.Response response = await http.post(Uri.parse(registerUrl), body: body);
  final data = jsonDecode(response.body);
   
if ( response.statusCode == 201 || response.statusCode == 202) {
    return User.fromJson(data);
    //jsonDecode بواسطة  json ل  string  لهيك رح احولو من  string بكون  body ال  
    //user من ال  object اللي هو  modelل  json هون رح احول من  
  }
  else  if (data["errors"] != null) {
    final errors = data["errors"] as Map<String, dynamic>;
    if (errors.containsKey("email")) {
      return Future.error(errors["email"][0]);
    }
   }

   return Future.error(data["message"] ?? "Failed to Register");
 
}
