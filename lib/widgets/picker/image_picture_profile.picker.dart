import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/view_models/profile.vm.dart';
import 'package:read_novel/view_models/register_as_writer.vm.dart';
import 'package:read_novel/widgets/card_image/img_profile.widget.dart';
import 'package:read_novel/widgets/dialogs/custom_pick_image_source.dialog.dart';
import 'package:velocity_x/velocity_x.dart';

class ImagePictureProfilePickerView extends StatefulWidget {
  const ImagePictureProfilePickerView({Key? key, required this.vm})
      : super(key: key);

  final ProfileViewModel vm;

  @override
  _ImagePictureProfilePickerViewState createState() =>
      _ImagePictureProfilePickerViewState();
}

class _ImagePictureProfilePickerViewState
    extends State<ImagePictureProfilePickerView> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        (showSelectedImage()
                ? CircleAvatar(
                    radius: 43,
                    backgroundColor: AppColor.fadedGrey,
                    child: CircleAvatar(
                      radius: 43 - 1.5,
                      backgroundColor: AppColor.ghostWhite,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: FileImage(
                                File(widget.vm.selectedProfilePic!.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ).clipOval().p2(),
                    ),
                  )
                : const ImageProfileWidget())
            .centered(),
        8.height,
        'klik gambar untuk mengupdate'.text.italic.sm.gray400.make().centered()
      ],
    ).onTap(pickNewPhoto);
  }

  bool showSelectedImage() {
    return widget.vm.selectedProfilePic != null;
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
      widget.vm.selectedProfilePic = XFile(pickedFile.path);
      //
      widget.vm.onImageSelected(widget.vm.selectedProfilePic!);
    }
  }

//dialog

}
