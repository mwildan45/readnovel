import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/dashboard.vm.dart';
import 'package:read_novel/views/pages/dashboard/widgets/fragments/carousel_image.fragment.dart';
import 'package:read_novel/widgets/list_items/novel.item.dart';
import 'package:read_novel/widgets/listview_builder/list_author.builder.dart';
import 'package:read_novel/widgets/listview_builder/list_novel.builder.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeTabWidget extends StatefulWidget {
  const HomeTabWidget({Key? key, required this.vm}) : super(key: key);
  final DashboardViewModel vm;

  @override
  State<HomeTabWidget> createState() => _HomeTabWidgetState();
}

class _HomeTabWidgetState extends State<HomeTabWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      controller: widget.vm.refreshController,
      onRefresh: widget.vm.onRefresh,
      header: MaterialClassicHeader(color: AppColor.royalOrange, height: 40),
      child: SingleChildScrollView(
        child: VStack(
          [
            CarouselImageDashboardFragment(vm: widget.vm),
            ListNovelBuilder(
              label: 'Buku Populer',
              onTapSeeAll: () => widget.vm.openSeeAllNovels(AppStrings.popular),
              onLoading: widget.vm.isBusy,
              itemCount: widget.vm.data?.novelPopuler?.length,
              itemGrowable: List.generate(
                widget.vm.data?.novelPopuler?.length ?? 0,
                (index) {
                  return NovelItem(
                    index: index,
                    novel: widget.vm.data?.novelPopuler?[index],
                    onItemTap: () => widget.vm.openNovel(widget.vm.data?.novelPopuler?[index].id, widget.vm.data?.novelPopuler?[index]),
                  );
                },
              ),
            ),
            ListNovelBuilder(
              label: 'Wajib Dibaca',
              onTapSeeAll: () => widget.vm.openSeeAllNovels(AppStrings.wajib),
              isGridType: true,
              onLoading: widget.vm.isBusy,
              itemCount: widget.vm.data?.wajibDibaca?.length,
              itemBuilder: (context, index) {
                return NovelItem(
                  index: index,
                  novel: widget.vm.data?.wajibDibaca?[index],
                  smallNovelItem: true,
                  onItemTap: () => widget.vm.openNovel(widget.vm.data?.wajibDibaca?[index].id, widget.vm.data?.wajibDibaca?[index]),
                );
              },
            ),
            const ListAuthorBuilder(
              label: 'Authors',
            ),
            ListNovelBuilder(
              label: 'Disukai Pembaca',
              onTapSeeAll: () => widget.vm.openSeeAllNovels(AppStrings.disukai),
              onLoading: widget.vm.isBusy,
              itemCount: widget.vm.data?.novelDisukai?.length,
              itemGrowable: List.generate(
                widget.vm.data?.novelDisukai?.length ?? 0,
                    (index) {
                  return NovelItem(
                    index: index,
                    novel: widget.vm.data?.novelDisukai?[index],
                    onItemTap: () => widget.vm.openNovel(widget.vm.data?.novelDisukai?[index].id, widget.vm.data?.novelDisukai?[index]),
                  );
                },
              ),
            ),
            ListNovelBuilder(
              label: 'Buku Baru Pilihan',
              onTapSeeAll: () => widget.vm.openSeeAllNovels(AppStrings.baru),
              isGridType: true,
              onLoading: widget.vm.isBusy,
              itemCount: widget.vm.data?.bukuBaru?.length,
              itemBuilder: (context, index) {
                return NovelItem(
                  index: index,
                  novel: widget.vm.data?.bukuBaru?[index],
                  smallNovelItem: true,
                  onItemTap: () => widget.vm.openNovel(widget.vm.data?.bukuBaru?[index].id, widget.vm.data?.bukuBaru?[index]),
                );
              },
            ),
            ListNovelBuilder(
              label: 'Rekomendasi Pilihan',
              onTapSeeAll: () => widget.vm.openSeeAllNovels(AppStrings.rekomendasi),
              onLoading: widget.vm.isBusy,
              itemCount: widget.vm.data?.rekomendasi?.length,
              itemGrowable: List.generate(
                widget.vm.data?.rekomendasi?.length ?? 0,
                    (index) {
                  return NovelItem(
                    index: index,
                    novel: widget.vm.data?.rekomendasi?[index],
                    onItemTap: () => widget.vm.openNovel(widget.vm.data?.rekomendasi?[index].id, widget.vm.data?.rekomendasi?[index]),
                  );
                },
              ),
            ),
            ListNovelBuilder(
              label: 'Kamu Mungkin Suka',
              onTapSeeAll: () => widget.vm.openSeeAllNovels(AppStrings.pilihan),
              isVerticalList: true,
              onLoading: widget.vm.isBusy,
              itemCount: widget.vm.data?.mungkinSuka?.length,
              itemBuilder: (context, index) {
                return NovelItem(
                  isInfoOnRightPosition: true,
                  index: index,
                  novel: widget.vm.data?.mungkinSuka?[index],
                  onItemTap: () => widget.vm.openNovel(widget.vm.data?.mungkinSuka?[index].id, widget.vm.data?.mungkinSuka?[index]),
                );
              },
            ),
            UiSpacer.verticalSpace(space: Vx.dp12)
          ],
        ).pOnly(left: Vx.dp12, right: Vx.dp12),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
