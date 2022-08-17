import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/text.styles.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final double? iconSize;
  final Widget? child;
  final TextStyle? titleStyle;
  final Function()? onPressed;
  final OutlinedBorder? shape;
  final bool isFixedHeight;
  final double? height;
  final bool loading;
  final double? shapeRadius;
  final Color? color;
  final Color? iconColor;
  final double? elevation;

  const CustomButton({
    this.title,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.child,
    this.onPressed,
    this.shape,
    this.isFixedHeight = false,
    this.height,
    this.loading = false,
    this.shapeRadius = Vx.dp4,
    this.color,
    this.titleStyle,
    this.elevation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      padding: const EdgeInsets.all(0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          primary: color ?? AppColor.cyan,
          onSurface: loading ? AppColor.primaryColor : null,
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(shapeRadius ?? 0),
              ),

        ),
        onPressed: loading ? null : onPressed,
        child: /*loading
            ? BusyIndicatorButton()
            : */SizedBox(
                width: null, //double.infinity,
                height: isFixedHeight ? Vx.dp32 : (height ?? Vx.dp48),
                child: child ??
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon != null
                            ? Icon(icon,
                                    color: iconColor ?? Colors.white,
                                    size: iconSize ?? 20,)
                                .pOnly(
                                right: Vx.dp5,
                                left: Vx.dp5,
                              )
                            : UiSpacer.emptySpace(),
                        title != null && title!.isNotBlank
                            ? Text(
                                title ?? "",
                                textAlign: TextAlign.center,
                                style: titleStyle ??
                                    TextStyles.h5TitleTextStyle(
                                      color: Colors.white,
                                    ),
                              ).centered()
                            : UiSpacer.emptySpace(),
                      ],
                    ),
              ),
      ),
    );
  }
}
