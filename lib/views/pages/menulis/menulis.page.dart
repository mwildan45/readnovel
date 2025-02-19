// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:read_novel/constants/app_colors.dart';
// import 'package:read_novel/view_models/write_novel.vm.dart';
// import 'package:read_novel/views/pages/menulis/menulis_novel_step/create_update_novel.page.dart';
// import 'package:read_novel/views/pages/menulis/menulis_novel_step/write_chapter.page.dart';
// import 'package:read_novel/widgets/base.page.dart';
// import 'package:read_novel/widgets/buttons/custom_button.dart';
// import 'package:stacked/stacked.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// class MenulisPage extends StatefulWidget {
//   const MenulisPage({Key? key}) : super(key: key);
//
//   @override
//   State<MenulisPage> createState() => _MenulisPageState();
// }
//
// class _MenulisPageState extends State<MenulisPage> {
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<WriteNovelViewModel>.reactive(
//       viewModelBuilder: () => WriteNovelViewModel(context),
//       onModelReady: (model) => model.initialise(),
//       builder: (context, vm, child) {
//         return BasePage(
//           floatingActionWidget: HStack(
//             [
//               CustomButton(
//                 onPressed: () => vm.onTabChange(vm.currentIndex - 1),
//                 title: 'Kembali',
//               ).w(120).h(40),
//               const Spacer(),
//               CustomButton(
//                 loading: vm.isBusy,
//                 onPressed: () => vm.currentIndex == 0 ? vm.addNovel() : vm.onTabChange(vm.currentIndex + 1),
//                 color: AppColor.guppieGreen,
//                 title: 'Selanjutnya',
//               ).w(120).h(40),
//             ],
//           ).px8(),
//           floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//           body: SafeArea(
//             child: PageView(
//               controller: vm.pageViewController,
//               onPageChanged: vm.onPageChanged,
//               physics: const NeverScrollableScrollPhysics(),
//               children: [
//                 CreateUpdateNovelPage(
//                   vm: vm,
//                 ),
//                 WriteChapterPage(vm: vm)
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
