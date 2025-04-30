import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../linkapi.dart';

class MainCircleImage extends StatelessWidget {
  final String image;
  const MainCircleImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      width: 85.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          330.r,
        ),
        child: Image.network(
          image != null
              ? "${AppLink.imageUsers}"
              : 'https://img.freepik.com/premium-photo/handsome-male-model-man-smiling-with-perfectly-clean-teeth-stock-photo-dental-background_592138-1188.jpg?w=2000',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
