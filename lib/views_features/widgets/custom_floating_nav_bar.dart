import 'package:flutter/material.dart';

import '../../core/util/constants.dart';

class CustomFloatingNavBar extends StatelessWidget {
  final int currentIndex;

  final Function(int)? onTap;



  const CustomFloatingNavBar(

      {super.key, required this.currentIndex, this.onTap});
  @override
  Widget build(BuildContext context) {
    // 1. الحاوية الخارجية لإضافة الـ Margin الأفقي والتحكم في الـ Padding السفلي
    return Container(
      // margin أفقي لجعله عائمًا من الجوانب
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      
      // **تعديل حاسم:** نستخدم Padding سفلي ثابت (30) يرفع الشريط عن حافة الشاشة
      // هذا الـ Padding لا يسبب تداخلاً لأنه يطبق على الـ Container، وليس على المنطقة الآمنة للنظام
      padding: const EdgeInsets.only(bottom: 30.0), 
      
      // 2. الحاوية الداخلية للتصميم (الشكل الدائري واللون)
      child: Container(
        height: 70, // الارتفاع
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: -2,
            ),
          ],
        ),
        
        // 3. وضع BottomNavigationBar مباشرة داخل الحاوية
        child: ClipRRect( // استخدام ClipRRect هنا لقص الحواف بشكل صحيح
          borderRadius: BorderRadius.circular(60),
          child: BottomNavigationBar( 
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            // يجب أن يكون اللون شفافاً لكي يظهر لون الـ Container كخلفية
            backgroundColor: Colors.transparent, 
            selectedItemColor: Colors.white,
            selectedIconTheme: const IconThemeData(size: 40),
            unselectedItemColor: Colors.grey.shade300,
            currentIndex: currentIndex,
            onTap: onTap,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.emergency_share), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
            ],
          ),
        ),
      ),
    );
  }
}