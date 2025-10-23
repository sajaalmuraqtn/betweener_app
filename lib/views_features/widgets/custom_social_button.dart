import 'package:betweeener_app/core/util/constants.dart';
import 'package:flutter/material.dart';

class CustomSocialButton extends StatelessWidget {
  const CustomSocialButton({super.key,required this.platform,required this.usernamePlatform});

   final String platform;
   final String usernamePlatform;

  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: EdgeInsets.all(10),
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: kLightSecondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            platform,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kOnSecondaryColor,
              overflow: TextOverflow.ellipsis
            ),
          ),
          Text(
            '@$usernamePlatform',
            style: TextStyle(color: kOnSecondaryColor),
          ),
        ],
      ),
    );;
  }
}