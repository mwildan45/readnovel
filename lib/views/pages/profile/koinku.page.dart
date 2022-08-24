import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/coin.vm.dart';
import 'package:read_novel/view_models/profile.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class KoinkuPage extends StatelessWidget {
  const KoinkuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CoinViewModel>.reactive(
      viewModelBuilder: () => CoinViewModel(context),
      onModelReady: (model) => model.getCoinsTopUp(),
      builder: (context, vm, child) {
        return BasePage(
          withAppBar: true,
          activeContext: context,
          isLoading: vm.busy(vm.coinsTopUp),
          body: VStack(
            [
              8.height,
              'Koinku'.text.lg.bold.make().center().px16(),
              8.height,
              HStack(
                [
                  _buildCoin(),
                  8.width,
                  '0'.text.bold.xl4.make()
                ],
              ).center(),
              UiSpacer.verticalSpace(),
              DynamicHeightGridView(
                shrinkWrap: true,
                itemCount: vm.coinsTopUp?.length ?? 0,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                builder: (context, index) {
                  return VStack(
                    [
                      HStack(
                        [
                          _buildCoin(),
                          4.width,
                          '${vm.coinsTopUp?[index].name} Koin'.text.lg.make(),
                        ],
                      ),
                      'Rp. ${vm.coinsTopUp?[index].price}'.text.lg.make(),
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                    alignment: MainAxisAlignment.spaceAround,
                  ).h(100).box.rounded.white.shadowMd.make();
                },
              ).px16().expand()
            ],
          ),
        );
      },
    );
  }

  Widget _buildCoin() {
    return const Icon(
      FontAwesomeIcons.c,
      size: 12,
    )
        .box
        .p3
        .color(Colors.yellow)
        .roundedFull
        .make()
        .box
        .color(Colors.orange)
        .p3
        .roundedFull
        .make();
  }
}
