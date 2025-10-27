import 'package:betweeener_app/controllers/followers_controller.dart';
import 'package:betweeener_app/controllers/link_controller.dart';
import 'package:betweeener_app/controllers/user_controller.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/follow_model.dart';
import 'package:betweeener_app/models/link_response_model.dart';
import 'package:betweeener_app/views_features/links/add_link_view.dart';
import 'package:betweeener_app/views_features/links/edit_link_view.dart';
import 'package:betweeener_app/views_features/profile/editprofile_view.dart';
import 'package:betweeener_app/views_features/widgets/custom_following_widget_button.dart';
import 'package:betweeener_app/views_features/widgets/custom_profile_avater_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  static String id = '/profileView';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<LinkElement> links = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getLinks();
  }

  Future<void> getLinks() async {
    try {
      final result = await getUserLinks();
      setState(() {
        links = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load links')));
    }
  }

  void deleteLink(LinkElement link) async {
    await deleteUserLink(link.id);

    setState(() {
      getLinks();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link Deleted successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void editLink(LinkElement oldLink) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditLinkView(link: oldLink)),
    );

    if (result != null && result is LinkElement) {
      int index = links.indexWhere((l) => l.id == oldLink.id);
      if (index != -1) {
        setState(() {
          getLinks();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Link Updated successfully'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomProfileCard(),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : links.isEmpty
                ? const Center(child: Text("No Links"))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: links.length,
                    itemBuilder: (context, index) {
                      final link = links[index];
                      return CustomSlidableSocialLink(link);
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: FloatingActionButton(
          onPressed: () async {
            final newLink = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddLinkView()),
            );

            if (newLink != null && newLink is LinkElement) {
              setState(() {
                links.add(newLink);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Link Added successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          backgroundColor: kPrimaryColor,

          child: const Icon(Icons.add, color: Colors.white),
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
      child: FutureBuilder(
        future: getCurrentUser(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomProfileAvaterWidget(height: 80),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${snapshot.data!.user.name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${snapshot.data!.user.email}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const Text(
                        '+9700000000',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      FutureBuilder<FollowModel>(
                        future: getFollowInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("Error: ${snapshot.error}"),
                            );
                          } else if (snapshot.hasData) {
                            final data = snapshot.data!;
                              return Row(
                            children: [
                              CustomFollowingWidgetButton(text: "followers ${data.followersCount}"),
                              SizedBox(width: 10),
                              CustomFollowingWidgetButton(text: "following ${data.followingCount}"),
                            ],
                          );
                          } else {
                            return const Text("No data found");
                          }
                        },
                      ),
                    ],
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.mode_edit_outlined,
                    color: kLightPrimaryColor,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditProfileInfoView(userInfo: snapshot.data!.user),
                      ),
                    );
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget CustomSlidableSocialLink(LinkElement link) {
    return Slidable(
      key: ValueKey(link.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.35,
        children: [
          const SizedBox(width: 8), // مسافة بسيطة بين الأزرار
          // ✏️ تعديل
          SlidableAction(
            onPressed: (_) => editLink(link),
            backgroundColor: kSecondaryColor,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            borderRadius: BorderRadius.circular(15),
          ),
          const SizedBox(width: 8), // مسافة بسيطة بين الأزرار
          // ❌ حذف
          SlidableAction(
            onPressed: (_) => deleteLink(link),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(15),
          ),
        ],
      ),
      child: CustomSocialLinkContent(
        platform: link.title,
        url: link.link,
        color: kLightDangerColor!,
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
