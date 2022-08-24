import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/view_models/home.vm.dart';
import 'package:read_novel/views/pages/dashboard/dashboard.page.dart';
import 'package:read_novel/views/pages/library/library.page.dart';
import 'package:read_novel/views/pages/menulis/menulis_menu.page.dart';
import 'package:read_novel/views/pages/profile/profile.page.dart';
import 'package:read_novel/widgets/base.page.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return BasePage(
            title: "D'lovera",
            body: DoubleBackToCloseApp(
              snackBar: const SnackBar(
                content: Text("Tekan sekali lagi untuk keluar"),
              ),
              child: PageView(
                controller: model.pageViewController,
                onPageChanged: model.onPageChanged,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  DashboardPage(),
                  LibraryPage(),
                  MenulisMenuPage(),
                  ProfilePage(),
                ],
              ),
            ),
            bottomNavigationBar: VxBox(
              child: SafeArea(
                child:  GNav(
                  tabBackgroundGradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [AppColor.royalOrange, AppColor.cerisePink],
                  ),
                  gap: 8,
                  tabBorderRadius: 15,
                  color: Colors.grey[600],
                  activeColor: Colors.white,
                  iconSize: 20,
                  textStyle: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                  tabBackgroundColor: Colors.grey[800]!,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 500),
                  tabs: List.generate(model.listMenu.length, (index) => GButton(
                    icon: model.listIconMenu[index],
                    text: model.listMenu[index],
                    iconSize: 15,
                  )),
                  selectedIndex: model.currentIndex,
                  onTabChange: model.onTabChange,
                ),
              )
            ).padding(const EdgeInsets.symmetric(horizontal: 12, vertical: 8))
                .shadow
                .color(AppColor.primaryColor)
                .make(),
          );
        }
    );
  }
}
