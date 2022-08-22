import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ParagraphBusyIndicator extends StatelessWidget {
  const ParagraphBusyIndicator({
    Key? key,
    this.height = 10, this.lines = 3,
  }) : super(key: key);

  final double height;
  final int lines;

  @override
  Widget build(BuildContext context) {
    return SkeletonParagraph(
      style: SkeletonParagraphStyle(
        lines: lines,
        spacing: 6,
        lineStyle: SkeletonLineStyle(
          randomLength: true,
          height: height,
          borderRadius: BorderRadius.circular(8),
          minLength: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
