import 'package:betweeener_app/controllers/followers_controller.dart';
import 'package:betweeener_app/controllers/link_controller.dart';
import 'package:betweeener_app/controllers/user_controller.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/link_response_model.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/views_features/widgets/custom_following_widget_button.dart';
import 'package:betweeener_app/views_features/widgets/custom_loading.dart';
import 'package:betweeener_app/views_features/widgets/custom_profile_avater_widget.dart';
import 'package:flutter/material.dart';

class FriendProfileView extends StatefulWidget {
  const FriendProfileView({super.key, required this.name, required this.email, required this.userId});
  static String id = '/profileView';
  final String name;
  final String email;
  final int? userId;

  @override
  State<FriendProfileView> createState() => _FriendProfileViewState();
}

class _FriendProfileViewState extends State<FriendProfileView> {
  List<LinkElement> links = [];
  bool? isFollowed; // nullable => لنعرف متى تم تحميلها

  Future<void> _isFollowedUserBefore() async {
    bool followed = await isFollowedUserBefore(widget.userId!);
    setState(() {
      isFollowed = followed;
    });
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
          "${widget.name} Profile",
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isFollowed == null
          ? CustomLoading() // تحميل البيانات
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomProfileCard(),
                  const SizedBox(height: 20),
                  CustomSocialLinkContent(
                    url: "instagram.com/${widget.name}",
                    platform: "instagram",
                    color: const Color.fromARGB(255, 237, 143, 160),
                  ),
                  CustomSocialLinkContent(
                    url: "facebook.com/${widget.name}",
                    platform: "facebook",
                    color: const Color.fromARGB(255, 132, 212, 255),
                  ),
                  CustomSocialLinkContent(
                    url: "x.com/${widget.name}",
                    platform: "facebook",
                    color: kLightDangerColor,
                  ),
                  CustomSocialLinkContent(
                    url: "snapchat.com/${widget.name}",
                    platform: "snapchat",
                    color: const Color.fromARGB(129, 255, 250, 104),
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
                  '${widget.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.email}',
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
                          await addFollow(widget.userId!);
                          setState(() {
                            isFollowed = true;
                          });
                         SnackBarShowMessage(context: context, color: Colors.green, message: 'You are now following this user');
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
