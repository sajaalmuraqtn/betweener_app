// To parse this JSON data, do
//
//     final FollowModel = followFromJson(jsonString);

import 'dart:convert';

FollowModel followFromJson(String str) => FollowModel.fromJson(json.decode(str));

String followToJson(FollowModel data) => json.encode(data.toJson());

class FollowModel {
    int followingCount;
    int followersCount;
    List<dynamic> following;
    List<dynamic> followers;

    FollowModel({
        required this.followingCount,
        required this.followersCount,
        required this.following,
        required this.followers,
    });

    factory FollowModel.fromJson(Map<String, dynamic> json) => FollowModel(
        followingCount: json["following_count"],
        followersCount: json["followers_count"],
        following: List<dynamic>.from(json["following"].map((x) => x)),
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "following_count": followingCount,
        "followers_count": followersCount,
        "following": List<dynamic>.from(following.map((x) => x)),
        "followers": List<dynamic>.from(followers.map((x) => x)),
    };
}
