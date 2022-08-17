import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class NovelItem extends StatelessWidget {
  const NovelItem({
    Key? key,
    this.image,
    this.index,
    this.height = 170,
    this.width = 100,
    this.author,
    this.widthCover = 85,
    this.heightCover = 120,
    this.isInfoOnRightPosition = false,
    this.isCenteredContent = false,
  }) : super(key: key);
  final String? image;
  final int? index;
  final double width, height, widthCover, heightCover;
  final String? author;
  final bool isInfoOnRightPosition;
  final bool isCenteredContent;

  @override
  Widget build(BuildContext context) {
    if (!isInfoOnRightPosition) {
      return VStack(
        [
          Image.network(
            image ?? '',
            fit: BoxFit.cover,
          ).w(widthCover).h(heightCover).cornerRadius(5),
          UiSpacer.verticalSpace(space: Vx.dp2),
          Flexible(
            child: 'Novel Placeholder asdasd asdas asd ad ${index! + 1}'
                .text.size(13).align(isCenteredContent ? TextAlign.center : TextAlign.start)
                .ellipsis
                .maxLines(2)
                .bold
                .make()
                .pOnly(right: 8),
            // .expand(),
          ),
          author == null ? const SizedBox.shrink() : '$author'.text.sm.make(),
          'Romance'.text.sm.gray500.make()
        ],
        crossAlignment: isCenteredContent ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      ).w(width).h(height);
    } else {
      return HStack(
        [
          Image.network(
            image ?? '',
            fit: BoxFit.cover,
          ).w(widthCover).h(heightCover).cornerRadius(5),
          VStack([
            Flexible(
              child: 'Novel Placeholder ${index! + 1}'
                  .text.size(13)
                  .ellipsis
                  .maxLines(1)
                  .bold
                  .make(),
              // .expand(),
            ),
            '$author'.text.sm.make(),
            'Romance'.text.sm.gray500.make(),
            Flexible(
              child: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                      ' Quisque tincidunt nunc risus, vitae facilisis purus cursus vitae. Nullam ac augue vitae est ultrices rhoncus quis id lacus. '
                      'Curabitur nec volutpat mi. Integer in magna odio. Integer porttitor erat in vehicula tempor. Sed sed ex erat. Mauris quis lacus '
                      'quis arcu sagittis sodales. Vivamus mollis eget sem eu imperdiet. Phasellus vel sagittis quam, vel egestas nibh. In volutpat,'
                      ' libero eget fringilla feugiat, odio quam ultricies augue, eu condimentum urna ex quis arcu. Aliquam sit amet purus'
                      ' condimentum, auctor ipsum in, congue risus. Etiam ante arcu, imperdiet non enim et, ullamcorper cursus justo. Sed et lorem '
                      'venenatis, dapibus purus sit amet, malesuada '
                      'sapien. Quisque ornare finibus leo ullamcorper lacinia. Pellentesque fermentum mattis dolor, non dictum turpis dapibus quis.'
                  .text.ellipsis.size(12).maxLines(3)
                  .make(),
            ),
          ]).p8().expand()
        ],
        crossAlignment: CrossAxisAlignment.start,
      ).pOnly(bottom: 8);
    }
  }
}
