import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:read_novel/view_models/coin.vm.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class KoinkuPage extends StatelessWidget {
  const KoinkuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CoinViewModel>.reactive(
      viewModelBuilder: () => CoinViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          withAppBar: true,
          activeContext: context,
          isLoading: vm.busy(vm.coinsTopUp),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: VStack(
              [
                8.height,
                'Koinku'.text.lg.bold.make().center().px16(),
                8.height,
                HStack(
                  [
                    _buildCoin(),
                    8.width,
                    "${vm.coinUser == "" || vm.coinUser == null ? 0 : vm.coinUser }".text.bold.xl4.make()
                  ],
                ).center(),
                UiSpacer.verticalSpace(),
                GridView.count(
                  padding: const EdgeInsets.symmetric(horizontal: Vx.dp16, vertical: Vx.dp5),
                  shrinkWrap: true,
                  primary: false,
                  // itemCount: vm.coinsTopUp?.length ?? 0,
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: List.generate(vm.coinsTopUp?.length ?? 0, (index) {
                    return VStack(
                      [
                        VStack(
                          [
                            _buildCoin(size: Vx.dp32),
                            UiSpacer.verticalSpace(space: Vx.dp12),
                            '${vm.coinsTopUp?[index].name} Koin'.text.xl.bold.make(),
                          ],
                          crossAlignment: CrossAxisAlignment.center,
                        ),
                        'Rp. ${vm.coinsTopUp?[index].price}'.text.bold.lg.make(),
                      ],
                      crossAlignment: CrossAxisAlignment.center,
                      alignment: MainAxisAlignment.spaceAround,
                    ).box.rounded.white.shadowMd.make().onTap(() => vm.buyCoin(vm.coinsTopUp?[index].id));
                  }),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCoin({double? size}) {
    return Icon(
      FontAwesomeIcons.c,
      size: size ?? 12,
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
