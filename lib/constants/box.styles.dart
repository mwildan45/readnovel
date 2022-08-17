import 'package:read_novel/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BoxStyles {
  static BoxDecoration boxContent() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: AppColor.shimmerBaseColor ?? Colors.white,
              offset: const Offset(0, 2),
              spreadRadius: 2,
              blurRadius: 1
          )
        ]
    );
  }
}