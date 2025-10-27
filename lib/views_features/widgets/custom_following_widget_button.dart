import 'dart:ffi';

import 'package:betweeener_app/core/util/constants.dart';
import 'package:flutter/material.dart';

class CustomFollowingWidgetButton extends StatelessWidget {
  const CustomFollowingWidgetButton({
    required this.text,
    super.key,
     this.onTap
  });
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(40),
      color: kSecondaryColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: SizedBox(
          width: 100,
          height: 30,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
