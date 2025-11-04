import 'package:betweeener_app/controllers/user_controller.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/core/util/styles.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/views_features/profile/frindprofile_view.dart';
import 'package:flutter/material.dart';

class FollowlistView extends StatelessWidget {
  static String id = '/followlistView';

    FollowlistView({super.key,required this.followelist,required this.title});

  final List<dynamic> followelist ;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        title:   Text(
          '$title ( ${followelist.length} )',
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
   
          // نتائج البحث
          Expanded(
            child:   followelist.isEmpty
                ? const Center(child: Text("No users found"))
                : ListView.builder(
                    itemCount: followelist.length,
                    itemBuilder: (context, index) {
                      return _buildPersonTile(followelist[index]!,context);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonTile(dynamic user,context) {
    return Card(
      color: kLightPrimaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: ListTile(
        leading: Icon(
          Icons.person,
          color: const Color(0xFF2B2B4F).withOpacity(0.8),
          size: 30,
        ),
        title: Text(
          "${user['name']}",
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "${user["email"]}",
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: kPrimaryColor,
        ),
        onTap: () {
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendProfileView(email:user['email'],name: user['name'],userId: user['id']),
            ),
          );
          // الانتقال إلى صفحة البروفايل
        },
      ),
    );
  }
}
