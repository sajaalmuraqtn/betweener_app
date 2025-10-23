import 'package:flutter/material.dart';

import '../../core/util/constants.dart';

class CustomFloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const CustomFloatingNavBar(
      {super.key, required this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 40.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: SizedBox(
           height: 70,
          child: SingleChildScrollView(
            child: Column(
              children: [
                BottomNavigationBar( 
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  elevation:0,
                  backgroundColor: kPrimaryColor,
                  selectedItemColor: Colors.white,
                  selectedIconTheme: const IconThemeData(size: 40),
                  unselectedItemColor: Colors.grey.shade300,
                  currentIndex: currentIndex,
                  onTap: onTap,
                  items:   [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.emergency_share), label: ''),
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                    BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
