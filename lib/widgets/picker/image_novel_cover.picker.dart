import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/view_models/write_novel.vm.dart';
import 'package:read_novel/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ImageNovelCoverSelectorView extends StatefulWidget {
  const ImageNovelCoverSelectorView({Key? key, required this.vm, this.urlImage})
      : super(key: key);

  final WriteNovelViewModel vm;
  final String? urlImage;

  @override
  _ImageNovelCoverSelectorViewState createState() => _ImageNovelCoverSelectorViewState();
}

class _ImageNovelCoverSelectorViewState extends State<ImageNovelCoverSelectorView> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        (showSelectedImage() || widget.urlImage != null
            ? Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: showSelectedImage() ? FileImage(File(widget.vm.selectedNovelCover!.path)) : NetworkImage(widget.urlImage!) as ImageProvider,
                fit: BoxFit.cover,
              )),
        )
            : const Icon(FontAwesomeIcons.image))
            .box
        .border(color: AppColor.fadedGrey)
        .rounded
        .width(130)
        .height(180)
        .make()
        .centered(),
        8.height,
        CustomButton(
          onPressed: pickNewPhoto,
          height: 30,
          title: widget.urlImage != null ? 'edit cover' : 'upload cover',
          color: AppColor.redScarlet,
          shapeRadius: 15,
        ).w(120).center(),
      ],
    );
  }

  bool showSelectedImage() {
    return widget.vm.selectedNovelCover != null;
  }

  //
  pickNewPhoto() async {
    var pickedFile;
    pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      widget.vm.selectedNovelCover = XFile(pickedFile.path);
      //
      widget.vm.onImageSelected(widget.vm.selectedNovelCover!);
    }
  }
}
