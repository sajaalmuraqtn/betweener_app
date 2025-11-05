import 'package:betweeener_app/controllers/link_controller.dart';
import 'package:betweeener_app/controllers/user_controller.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/link_response_model.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/views_features/auth/login_view.dart';
import 'package:betweeener_app/views_features/search/search_view.dart';
import 'package:betweeener_app/views_features/widgets/custom_loading.dart';
import 'package:betweeener_app/views_features/widgets/custom_social_button.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const id = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<LinkElement> links = []; 

  Future<List<LinkElement>> allLinks() async {
    links = await getUserLinks(); //api
    return links;
  }
    @override
  void initState() {
    super.initState();
    allLinks();
    UpdateUserLocation(context);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchByNameView()));},
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
            onPressed: () async{
             await logoutUser(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FutureBuilder لاسم المستخدم
              FutureBuilder(
                future: getCurrentUser(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Hello, ${snapshot.data!.user.name}!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return CustomLoading();
                  }
                },
              ),
              SizedBox(height: 30),

              // QR Code
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 350,
                      height: 330,
                      // color: Colors.amber,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/imgs/qrcode_bg.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: getCurrentUser(context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return QrImageView(
                            data: "${snapshot.data!.user.email}",
                            version: QrVersions.auto,
                            size: 250,
                            foregroundColor: kPrimaryColor,
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          return CustomLoading();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),

              Center(
                child: Container(color: kPrimaryColor, height: 5, width: 250),
              ),
              SizedBox(height: 10),

              FutureBuilder(
                future: allLinks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CustomLoading();
                  }
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    if (data.length==0) {
                      return Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          margin: EdgeInsets.all(10),
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: kLightPrimaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              final isAdded = await Navigator.pushNamed(
                                context,
                                '/addLink',
                              );
                              if (isAdded == true) {
                                setState(() {
                                  allLinks(); // إعادة تحميل الروابط
                                });
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.add, color: kPrimaryColor, size: 30),
                                Text(
                                  'Add Link',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    // حالة وجود عناصر
                    return SizedBox(
                      height: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length + 1, // +1 للزر
                        itemBuilder: (context, index) {
                          if (index == data.length) {
                            // زر Add new link بعد العناصر
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              margin: EdgeInsets.all(10),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: kLightPrimaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  final isAdded = await Navigator.pushNamed(
                                    context,
                                    '/addLink',
                                  );
                                  if (isAdded == true) {
                                    setState(() {
                                      allLinks(); // إعادة تحميل الروابط
                                    });
                                  }
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: kPrimaryColor,
                                      size: 30,
                                    ),
                                    Text(
                                      'Add Link',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return CustomSocialButton(
                              platform: data[index].link,
                              usernamePlatform: data[index].title,
                            );
                          }
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  } else {
                    return CustomLoading();
                  }
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
