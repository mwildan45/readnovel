import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/constants/app_assets.dart';
import 'package:read_novel/constants/app_colors.dart';
import 'package:read_novel/utils/ui_spacer.dart';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";

class BasePage extends StatefulWidget {
  const BasePage(
      {Key? key,
      this.title,
      required this.body,
      this.isLoading = false,
      this.extendBodyBehindAppBar = false,
      this.drawerMenu,
      this.withAppBar = false,
      this.floatingActionWidget,
      this.floatingActionButtonLocation,
      this.bottomNavigationBar,
      this.appBarTitleWidget,
      this.centerTitle = true,
      this.appBarActions,
      this.appBarLeading,
      this.customAppBar = false,
      this.activeContext, this.backgroundColorAppBar})
      : super(key: key);

  final String? title;
  final Widget? appBarTitleWidget;
  final Widget body;
  final Widget? drawerMenu;
  final Widget? floatingActionWidget;
  final Widget? bottomNavigationBar;
  final Widget? appBarLeading;
  final List<Widget>? appBarActions;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool withAppBar;
  final bool customAppBar;
  final bool isLoading;
  final bool extendBodyBehindAppBar;
  final bool? centerTitle;
  final BuildContext? activeContext;
  final Color? backgroundColorAppBar;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.primaryColor,
      appBar: widget.withAppBar
          ? widget.customAppBar
              ? AppBar(
                  title: widget.appBarTitleWidget ??
                      Text(widget.title ?? "title appbar"),
                  centerTitle: widget.centerTitle,
                  actions: widget.appBarActions,
                  leading: widget.appBarLeading,
                )
              : PreferredSize(
                  preferredSize: const Size.fromHeight(50.0),
                  child: AppBar(
                    backgroundColor: widget.backgroundColorAppBar ?? Colors.white,
                    centerTitle: true,
                    elevation: 0,
                    title: Image.asset(
                      AppImages.appLogoHorizontal,
                      width: 128,
                    ),
                    leading: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 18,
                      color: AppColor.romanSilver,
                    ).w(30).onTap(() => widget.activeContext?.navigator?.pop()),
                  ),
                )
          : null,
      body: VStack(
        [
          widget.isLoading
              ? const CircularProgressIndicator().center().expand()
              : widget.body.expand(),
        ],
      ),
      floatingActionButton: widget.floatingActionWidget,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      drawer: widget.drawerMenu,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
