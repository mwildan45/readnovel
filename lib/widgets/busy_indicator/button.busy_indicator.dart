import 'package:flutter/material.dart';

class BusyIndicatorButton extends StatelessWidget {
  const BusyIndicatorButton({this.color, Key? key}) : super(key: key);

  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color?>(
            color ?? Colors.white),
      ),
    );
  }
}
