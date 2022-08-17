import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/dashboard.vm.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:read_novel/widgets/list_items/novel.item.dart';
import 'package:read_novel/widgets/listview_builder/list_author.builder.dart';
import 'package:read_novel/widgets/listview_builder/list_novel.builder.dart';
import 'package:skeletons/skeletons.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeTabWidget extends StatelessWidget {
  const HomeTabWidget({Key? key, required this.vm}) : super(key: key);
  final DashboardViewModel vm;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: VStack(
        [
          Skeleton(
            skeleton: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: double.infinity,
                height: 140,
                // minHeight: MediaQuery.of(context).size.height / 8,
                // maxHeight: MediaQuery.of(context).size.height / 3,
              ),
            ),
            isLoading: vm.isBusy,
            child: VStack(
              [
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 3/1.2,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlay: true,
                    height: 140,
                    onPageChanged: vm.onSliderChanged,
                  ),
                  carouselController: vm.carouselController,
                  items: imageSliders(vm.bannerData),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: vm.bannerData == null
                      ? []
                      : vm.bannerData!.data!.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () =>
                                vm.carouselController.animateToPage(entry.key),
                            child: Container(
                              width: 10.0,
                              height: 10.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.cyan)
                                    .withOpacity(
                                  vm.currentSliderIndex == entry.key
                                      ? 0.9
                                      : 0.4,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                ),
              ],
            ),
          ),
          ListNovelBuilder(
            label: 'Buku Populer',
            itemCount: imgList.length ?? 10,
            itemBuilder: (context, index) {
              if (vm.isBusy) {
                return const SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      width: 100,
                      height: 170,
                      padding: EdgeInsets.only(right: Vx.dp8)
                      // minHeight: MediaQuery.of(context).size.height / 8,
                      // maxHeight: MediaQuery.of(context).size.height / 3,
                      ),
                );
              } else {
                return NovelItem(
                  image: imgList[index],
                  index: index,
                );
              }
            },
          ),
          const ListNovelBuilder(
            label: 'Wajib Dibaca',
            isGridType: true,
          ),
          const ListAuthorBuilder(
            label: 'Authors',
          ),
          const ListNovelBuilder(
            label: 'Disukai Pembaca',
          ),
          const ListNovelBuilder(
            label: 'Buku Baru Pilihan',
            isGridType: true,
          ),
          const ListNovelBuilder(
            label: 'Rekomendasi Pilihan',
          ),
          const ListNovelBuilder(
            label: 'Kamu Mungkin Suka',
            isVerticalList: true,
          ),
          UiSpacer.verticalSpace(space: Vx.dp12)
        ],
      ),
    );
  }
}
