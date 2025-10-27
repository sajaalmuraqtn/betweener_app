import 'package:betweeener_app/controllers/followers_controller.dart';
import 'package:betweeener_app/controllers/link_controller.dart';
import 'package:betweeener_app/controllers/user_controller.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/link_response_model.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/views_features/widgets/custom_following_widget_button.dart';
import 'package:betweeener_app/views_features/widgets/custom_profile_avater_widget.dart';
import 'package:flutter/material.dart';

class FriendProfileView extends StatefulWidget {
  const FriendProfileView({super.key, required this.user});
  static String id = '/profileView';
  final UserClass user;

  @override
  State<FriendProfileView> createState() => _FriendProfileViewState();
}

class _FriendProfileViewState extends State<FriendProfileView> {
  List<LinkElement> links = [];
  bool? isFollowed; // nullable => لنعرف متى تم تحميلها

  Future<void> _isFollowedUserBefore() async {
    bool followed = await isFollowedUserBefore(widget.user.id!);
    setState(() {
      isFollowed = followed;
    });
    print("isFollowed -> $isFollowed");
  }

  @override
  void initState() {
    super.initState();
    _isFollowedUserBefore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        title: Text(
          "${widget.user.name} Profile",
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isFollowed == null
          ? const Center(child: CircularProgressIndicator()) // تحميل البيانات
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomProfileCard(),
                  const SizedBox(height: 20),
                  CustomSocialLinkContent(
                    url: "instagram.com",
                    platform: "instagram",
                    color: kLightDangerColor,
                  ),
                  CustomSocialLinkContent(
                    url: "facebook.com",
                    platform: "facebook",
                    color: kLightDangerColor,
                  ),
                ],
              ),
            ),
    );
  }

  Widget CustomProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomProfileAvaterWidget(height: 80),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.user.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.user.email}',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                const Text(
                  '+9700000000',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 10),
                CustomFollowingWidgetButton(
                  text: isFollowed! ? "Followed" : "Follow",
                  onTap: isFollowed!
                      ? null
                      : () async {
                          await addFollow(widget.user.id!);
                          setState(() {
                            isFollowed = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("You are now following this user"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomSocialLinkContent({
    required String platform,
    required String url,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  platform,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  url,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
