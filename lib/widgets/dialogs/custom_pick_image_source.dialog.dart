import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

Future showPickerDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UiSpacer.verticalSpace(),
              'Pilih dari'.text.bold.make(),
              UiSpacer.verticalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () => context.pop('galeri'),
                      child: 'Galeri'.text.black.make()),
                  TextButton(
                      onPressed: () => context.pop('camera'),
                      child: 'Camera'.text.black.make()),
                ],
              ),
              8.height
            ],
          ),
        ).h48(context);
      });
}
