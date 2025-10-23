import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

//login الرد اللي رح يجي بس اعمل 
class User {
  UserClass user;
  String token;

  User({required this.user, required this.token});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(user: UserClass.fromJson(json["user"]), token: json["token"]);
      //body اللي هو ال  json اعطيتو 
      //من معلومات المستخدم اللي جبتها من الرد  object هون بدي اعمل 

  Map<String, dynamic> toJson() => {"user": user.toJson(), "token": token};
  
}

// كلاس يحتوي على معلومات المستخدم جميعها 
class UserClass {
  int? id;
  String? name;
  String? email;
  dynamic? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? isActive;
  dynamic? country;
  dynamic? ip;
  dynamic? long;
  dynamic? lat;

  UserClass({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.country,
    required this.ip,
    required this.long,
    required this.lat,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    isActive: json["isActive"],
    country: json["country"],
    ip: json["ip"],
    long: json["long"],
    lat: json["lat"],
  );

//  هون حولت من 

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "isActive": isActive,
    "country": country,
    "ip": ip,
    "long": long,
    "lat": lat,
  };
}
