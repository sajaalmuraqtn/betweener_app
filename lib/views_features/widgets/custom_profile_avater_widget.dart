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
        'https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_1280.png',
      ),fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(100),
     ),
    );
  }
}
