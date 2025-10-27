import 'package:betweeener_app/core/util/constants.dart';
import 'package:flutter/material.dart';

class ReceiveView extends StatelessWidget {
  static String id = '/receiveView';

  const ReceiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Active Sharing',
          style: TextStyle(
            color: kPrimaryColor, // لون نص داكن
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50), // مسافة علوية
      
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                ), // لتحديد مكان الدبوس بالنسبة للـ Wi-Fi
                child: Icon(
                  Icons.emergency_share, // أيقونة الدبوس
                  size: 150,
                  color: Colors.deepPurple.withOpacity(0.2), // لون فاتح
                ),
              ),
              const SizedBox(height: 50), // مسافة بين الأيقونات والقائمة
              // قائمة الأشخاص المشاركين
              _buildPersonTile('AHMED ALI'),
              const SizedBox(height: 15),
              _buildPersonTile('AHMED ALI'),
              const SizedBox(height: 15),
              _buildPersonTile('AHMED ALI'),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonTile(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.1), // لون بنفسجي فاتح جداً
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            Icons.person,
            color: const Color(
              0xFF2B2B4F,
            ).withOpacity(0.8), // لون أيقونة الشخص داكن
            size: 24,
          ),
          const SizedBox(width: 15),
          Text(
            name,
            style: TextStyle(
              color: const Color(
                0xFF2B2B4F,
              ).withOpacity(0.8), // لون نص الشخص داكن
              fontSize: 18,
              fontWeight: FontWeight.w600, // خط سميك قليلاً
            ),
          ),
        ],
      ),
    );
  }
}
