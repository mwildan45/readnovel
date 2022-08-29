import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class ImageProfileWidget extends StatelessWidget {
  const ImageProfileWidget({Key? key, this.radius = 43}) : super(key: key);
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColor.fadedGrey,
      child: CircleAvatar(
        radius: radius - 1.5,
        backgroundColor: AppColor.ghostWhite,
        child: CachedNetworkImage(
          imageUrl: getStringAsync(AppStrings.profileImg),
          fit: BoxFit.cover,
          errorWidget: (BuildContext context, String exception, stackTrace) {
            return CircleAvatar(
              radius: radius - 2,
              backgroundColor: AppColor.fadedGrey,
              child: Icon(FontAwesomeIcons.solidUser, size: radius - 4, color: AppColor.romanSilver,),
            );
          },
        ).clipOval().p2(),
      ),
    );
  }
}
