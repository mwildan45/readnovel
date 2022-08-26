import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:velocity_x/velocity_x.dart';

class BusyIndicatorNovelItem extends StatelessWidget {
  const BusyIndicatorNovelItem(
      {Key? key,
      this.width = 100,
      this.height = 170,
      this.minHeight,
      this.maxHeight})
      : super(key: key);
  final double width, height;
  final double? minHeight, maxHeight;

  @override
  Widget build(BuildContext context) {
    return SkeletonAvatar(
      style: SkeletonAvatarStyle(
        width: width,
        height: height,
        padding: const EdgeInsets.only(right: Vx.dp8),
        // minHeight: minHeight,
        // maxHeight: maxHeight,
      ),
    );
  }
}
