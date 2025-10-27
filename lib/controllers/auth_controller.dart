import 'dart:convert';

import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:http/http.dart' as http;

Future<User> login(Map<String, dynamic> body) async {
 /* http.post  دالة 

(loginURL) بتأخذ الرابط 

   اللي تحتوي على الايميل وكلمة المرور من المستخدم (Map اللي هو )  body والـ 

json وبتحوّله تلقائيًا إلى JSON فقط dartmap لأن السيرفر ما بفهم     

*/
  http.Response response = await http.post(Uri.parse(loginURL), body: body);

  if (response.statusCode == 200) {
    // بحالة نجح الارسال 
    // string (body from response) -> json -> userobject (to use info in ui)
    return User.fromJson(jsonDecode(response.body));
   } else {
    return Future.error("Failed to login");
  }
}

Future<User> register(Map<String, dynamic> body) async {
  //body-->>  data from user (name,password,confirmpassword,email) 
  
  http.Response response = await http.post(Uri.parse(registerUrl), body: body);
  // هون بعثنا بيانات انشاء الحساب من المستخدم 
  final data = jsonDecode(response.body);
  //user لحتى نحولها لكائن من نوع ال  json حولناها ل 
   
if ( response.statusCode == 201 || response.statusCode == 202) {
  // بحالة نجح بتسجيل حساب
    return User.fromJson(data);
    // convert json to User Object
    }
  else  if (data["errors"] != null) {
    // بحالة كان عندنا مشكلة بالايميل مثلا موجود مسبقاً
    final errors = data["errors"] as Map<String, dynamic>;
    if (errors.containsKey("email")) {
      return Future.error(errors["email"][0]);
    }
   }

   return Future.error(data["message"] ?? "Failed to Register");
 
}
