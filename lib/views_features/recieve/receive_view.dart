import 'package:betweeener_app/core/util/constants.dart';
import 'package:flutter/material.dart';

class ReceiveView extends StatelessWidget {
  static String id = '/receiveView';

  const ReceiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        title: const Text(
          'Active Sharing',
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),  
      
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                ),  
                child: Icon(
                  Icons.emergency_share, 
                  size: 150,
                  color: Colors.deepPurple.withOpacity(0.2),  
                ),
              ),
              const SizedBox(height: 50), 
               CustomPersonActive('AHMED ALI'),
              const SizedBox(height: 15),
              CustomPersonActive('AHMED ALI'),
              const SizedBox(height: 15),
              CustomPersonActive('AHMED ALI'),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomPersonActive(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.1),  
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            Icons.person,
            color: const Color(
              0xFF2B2B4F,
            ).withOpacity(0.8), 
            size: 24,
          ),
          const SizedBox(width: 15),
          Text(
            name,
            style: TextStyle(
              color: const Color(
                0xFF2B2B4F,
              ).withOpacity(0.8), 
              fontSize: 18,
              fontWeight: FontWeight.w600, 
            ),
          ),
        ],
      ),
    );
  }
}
