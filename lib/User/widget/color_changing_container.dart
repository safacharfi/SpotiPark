import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorChangingContainer extends StatelessWidget {
  final Color containerColor;
  final Color myTextColor;
  final String containerText;
  final Icon containerIcon;
  const ColorChangingContainer(
      {super.key,
      required this.containerColor,
      required this.myTextColor,
      required this.containerText,
      required this.containerIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 98.w,
      height: 125.h,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          containerIcon,
          SizedBox(height: 14.h),
          Text(
            containerText,
            style: TextStyle(
              fontFamily: 'Anta-Regular.ttf',
              fontSize: 20,
              color: myTextColor,
            ),
          )
        ],
      ),
    );
  }
}
