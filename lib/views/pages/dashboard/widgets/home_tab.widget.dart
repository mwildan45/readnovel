import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/dashboard.vm.dart';
import 'package:read_novel/widgets/busy_indicator/novel_item.busy_indicator.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:read_novel/widgets/list_items/novel.item.dart';
import 'package:read_novel/widgets/listview_builder/list_author.builder.dart';
import 'package:read_novel/widgets/listview_builder/list_novel.builder.dart';
import 'package:read_novel/widgets/no_image.dart';
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
          VStack(
            [
              Skeleton(
                skeleton: const SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    width: double.infinity,
                    height: 140,
                    // minHeight: MediaQuery.of(context).size.height / 8,
                    // maxHeight: MediaQuery.of(context).size.height / 3,
                  ),
                ),
                isLoading: vm.busy(vm.bannerData),
                child: VStack(
                  [
                    CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 3 / 1.2,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        autoPlay: true,
                        // height: 140,
                        onPageChanged: vm.onSliderChanged,
                      ),
                      carouselController: vm.carouselController,
                      items:
                          vm.bannerData == null || vm.bannerData!.data!.isEmpty
                              ? [const NoImagePlaceholder()]
                              : imageSliders(vm.bannerData),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: vm.bannerData == null
                          ? []
                          : vm.bannerData!.data!.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => vm.carouselController
                                    .animateToPage(entry.key),
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
                                            : AppColor.royalOrange)
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
                onLoading: vm.isBusy,
                itemCount: vm.data?.novelPopuler?.length,
                itemGrowable: List.generate(
                  vm.data?.novelPopuler?.length ?? 0,
                  (index) {
                    return NovelItem(
                      idNovel: vm.data?.novelPopuler?[index].id,
                      novelName: vm.data?.novelPopuler?[index].title,
                      image: vm.data?.novelPopuler?[index].cover,
                      index: index,
                      author: vm.data?.novelPopuler?[index].author,
                      onItemTap: () => vm.openNovel(vm.data?.novelPopuler?[index].id, vm.data?.novelPopuler?[index]),
                    );
                  },
                ),
              ),
              ListNovelBuilder(
                label: 'Wajib Dibaca',
                isGridType: true,
                onLoading: vm.isBusy,
                itemCount: vm.data?.wajibDibaca?.length,
                itemBuilder: (context, index) {
                  return NovelItem(
                    idNovel: vm.data?.wajibDibaca?[index].id,
                    image: vm.data?.wajibDibaca?[index].cover,
                    index: index,
                    author: vm.data?.wajibDibaca?[index].author,
                    novelName: vm.data?.wajibDibaca?[index].title,
                    smallNovelItem: true,
                    onItemTap: () => vm.openNovel(vm.data?.wajibDibaca?[index].id, vm.data?.wajibDibaca?[index]),
                  );
                },
              ),
              const ListAuthorBuilder(
                label: 'Authors',
              ),
              ListNovelBuilder(
                label: 'Disukai Pembaca',
                onLoading: vm.isBusy,
                itemCount: vm.data?.novelDisukai?.length,
                itemGrowable: List.generate(
                  vm.data?.novelDisukai?.length ?? 0,
                      (index) {
                    return NovelItem(
                      idNovel: vm.data?.novelDisukai?[index].id,
                      novelName: vm.data?.novelDisukai?[index].title,
                      image: vm.data?.novelDisukai?[index].cover,
                      index: index,
                      author: vm.data?.novelDisukai?[index].author,
                      onItemTap: () => vm.openNovel(vm.data?.novelDisukai?[index].id, vm.data?.novelDisukai?[index]),
                    );
                  },
                ),
              ),
              ListNovelBuilder(
                label: 'Buku Baru Pilihan',
                isGridType: true,
                onLoading: vm.isBusy,
                itemCount: vm.data?.bukuBaru?.length,
                itemBuilder: (context, index) {
                  return NovelItem(
                    idNovel: vm.data?.bukuBaru?[index].id,
                    image: vm.data?.bukuBaru?[index].cover,
                    index: index,
                    author: vm.data?.bukuBaru?[index].author,
                    novelName: vm.data?.bukuBaru?[index].title,
                    smallNovelItem: true,
                    onItemTap: () => vm.openNovel(vm.data?.bukuBaru?[index].id, vm.data?.bukuBaru?[index]),
                  );
                },
              ),
              ListNovelBuilder(
                label: 'Rekomendasi Pilihan',
                onLoading: vm.isBusy,
                itemCount: vm.data?.rekomendasi?.length,
                itemGrowable: List.generate(
                  vm.data?.rekomendasi?.length ?? 0,
                      (index) {
                    return NovelItem(
                      idNovel: vm.data?.rekomendasi?[index].id,
                      novelName: vm.data?.rekomendasi?[index].title,
                      image: vm.data?.rekomendasi?[index].cover,
                      index: index,
                      author: vm.data?.rekomendasi?[index].author,
                      onItemTap: () => vm.openNovel(vm.data?.rekomendasi?[index].id, vm.data?.rekomendasi?[index]),
                    );
                  },
                ),
              ),
              ListNovelBuilder(
                label: 'Kamu Mungkin Suka',
                isVerticalList: true,
                onLoading: vm.isBusy,
                itemCount: vm.data?.mungkinSuka?.length,
                itemBuilder: (context, index) {
                  return NovelItem(
                    isInfoOnRightPosition: true,
                    idNovel: vm.data?.mungkinSuka?[index].id,
                    novelName: vm.data?.mungkinSuka?[index].title,
                    image: vm.data?.mungkinSuka?[index].cover,
                    index: index,
                    author: vm.data?.mungkinSuka?[index].author,
                    novel: vm.data?.mungkinSuka?[index],
                    onItemTap: () => vm.openNovel(vm.data?.mungkinSuka?[index].id, vm.data?.mungkinSuka?[index]),
                  );
                },
              ),
              UiSpacer.verticalSpace(space: Vx.dp12)
            ],
          ).pOnly(left: Vx.dp12, right: Vx.dp12),
        ],
      ),
    );
  }
}
