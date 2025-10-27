import 'package:flutter/material.dart';

class CustomProfileAvaterWidget extends StatelessWidget {
  const CustomProfileAvaterWidget({
    super.key,
   required this.height
  });
  final double height ;
 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height,
      height: height,
     decoration: BoxDecoration(
      image: DecorationImage(image: NetworkImage(
        'https://cdn.prod.website-files.com/6600e1eab90de089c2d9c9cd/662c092880a6d18c31995e13_66236537d4f46682e079b6ce_Casual%2520Portrait.webp',
      ),fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(100),
     ),
    );
  }
}
