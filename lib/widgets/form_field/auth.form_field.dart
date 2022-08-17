import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/text.styles.dart';

class EditText extends StatefulWidget {
  var isPassword;
  var hintText;
  var isSecure;
  int fontSize;
  var textColor;
  var fontFamily;
  var text;
  var visible;
  var validator;
  var maxLine;
  TextEditingController? mController;
  VoidCallback? onPressed;
  Function? onFieldSubmitted;
  TextInputType? mKeyboardType;

  EditText({
    var this.fontSize = textSizeNormal,
    var this.textColor = Colors.black,
    var this.hintText = '',
    var this.isPassword = true,
    var this.isSecure = false,
    var this.text = "",
    var this.mController,
    this.validator,
    this.onFieldSubmitted,
    this.mKeyboardType,
    var this.maxLine = 1,
    var this.visible = false,
  });

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSecure) {
      return TextFormField(
        controller: widget.mController,
        obscureText: widget.isPassword,
        cursorColor: AppColor.grey,
        maxLines: widget.maxLine,
        readOnly: widget.visible,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted as void Function(String)?,
        keyboardType: widget.mKeyboardType,
        style: TextStyle(fontSize: widget.fontSize.toDouble(), color: Colors.black, fontFamily: widget.fontFamily),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(26, 16, 4, 16),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppColor.grey),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.primaryColorDark, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.primaryColorDark, width: 0.0),
          ),
          errorMaxLines: 2,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        ),
      );
    } else {
      return TextFormField(
        controller: widget.mController,
        obscureText: widget.isPassword,
        cursorColor: AppColor.grey,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted as void Function(String)?,
        style: TextStyle(fontSize: widget.fontSize.toDouble(), color: Colors.black, fontFamily: widget.fontFamily),
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                widget.isPassword = !widget.isPassword;
              });
            },
            child: Icon(
              widget.isPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(26, 18, 4, 18),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppColor.grey),
          filled: true,
          fillColor: Colors.white,
          errorMaxLines: 2,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.primaryColorDark, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.primaryColorDark, width: 0.0),
          ),
        ),
      );
    }
  }
}