import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/view_models/dashboard.vm.dart';
import 'package:read_novel/widgets/list_items/carousel_image.item.dart';
import 'package:read_novel/widgets/no_image.dart';
import 'package:skeletons/skeletons.dart';
import 'package:velocity_x/velocity_x.dart';

class CarouselImageDashboardFragment extends StatelessWidget {
  const CarouselImageDashboardFragment({Key? key, required this.vm}) : super(key: key);
  final DashboardViewModel vm;
  
  @override
  Widget build(BuildContext context) {
    return Skeleton(
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
    );
  }
}
