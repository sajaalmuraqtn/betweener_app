import 'package:betweeener_app/controllers/user_controller.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/core/util/styles.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/views_features/profile/frindprofile_view.dart';
import 'package:flutter/material.dart';

class SearchByNameView extends StatefulWidget {
  static String id = '/searchView';

  const SearchByNameView({super.key});

  @override
  State<SearchByNameView> createState() => _SearchByNameViewState();
}

class _SearchByNameViewState extends State<SearchByNameView> {
  final TextEditingController userNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<UserClass> foundUsers = [];
  bool isLoading = false;

  Future<void> searchByUsername() async {
    final name = userNameController.text.trim();
    if (name.isEmpty) return;

    setState(() => isLoading = true);
    try {
      final result = await searchUserByName({'name': name});
      setState(() {
        foundUsers = result;
        print("foundUsers->$foundUsers");
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    // كل مرة المستخدم يكتب فيها، نعمل بحث تلقائي بعد 500ms
    userNameController.addListener(() {
      if (userNameController.text.isNotEmpty) {
        searchByUsername();
      } else {
        setState(() {
          foundUsers = [];
        });
      }
    });
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        title: const Text(
          'Search By User Name',
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
          // حقل البحث
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: userNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      hintText: "Search By User Name",
                      border: Styles.primaryRoundedOutlineInputBorder,
                      focusedBorder: Styles.primaryRoundedOutlineInputBorder,
                      enabledBorder: Styles.primaryRoundedOutlineInputBorder,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: searchByUsername,
                  icon: const Icon(Icons.search, color: kPrimaryColor),
                ),
              ],
            ),
          ),

          // نتائج البحث
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : foundUsers.isEmpty
                ? const Center(child: Text("No users found"))
                : ListView.builder(
                    itemCount: foundUsers.length,
                    itemBuilder: (context, index) {
                      return _buildPersonTile(foundUsers[index]!);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonTile(UserClass user) {
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
          "${user.name}",
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "${user.email}",
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
          print("${user.email}");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendProfileView(user: user),
            ),
          );
          // الانتقال إلى صفحة البروفايل
        },
      ),
    );
  }
}
