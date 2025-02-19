import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/register_as_writer.vm.dart';
import 'package:read_novel/widgets/dialogs/custom_pick_image_source.dialog.dart';
import 'package:velocity_x/velocity_x.dart';

class ImageKTPSelectorView extends StatefulWidget {
  const ImageKTPSelectorView({Key? key, required this.vm})
      : super(key: key);

  final RegisterAsWriterViewModel vm;

  @override
  _ImageKTPSelectorViewState createState() => _ImageKTPSelectorViewState();
}

class _ImageKTPSelectorViewState extends State<ImageKTPSelectorView> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        (showSelectedImage()
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: FileImage(File(widget.vm.selectedPhotoKTP!.path)),
                          fit: BoxFit.cover,
                        )),
                  )
                : const Icon(FontAwesomeIcons.image))
            .box
            .white
            .border(color: AppColor.fadedGrey)
            .rounded
            // .width(210)
            // .height(130)
            .make()
            .h20(context)
            .w64(context)
            .centered(),
      ],
    ).onTap(pickNewPhoto);
  }

  bool showSelectedImage() {
    return widget.vm.selectedPhotoKTP != null;
  }

  //
  pickNewPhoto() async {
    var pickedFile;

    final val = await showPickerDialog(context);

    if (val == 'galeri') {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } else if (val == 'camera') {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }

    if (pickedFile != null) {
      widget.vm.selectedPhotoKTP = XFile(pickedFile.path);
      //
      widget.vm.onImageSelected(widget.vm.selectedPhotoKTP!);
    }
  }

  //dialog

}
