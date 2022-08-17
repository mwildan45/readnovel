import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: VStack(
        [
          child,
        ],
      ).p8(),
    );
  }
}
