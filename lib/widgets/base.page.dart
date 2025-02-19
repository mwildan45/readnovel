import 'package:loader_overlay/loader_overlay.dart';
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
      this.activeContext,
      this.backgroundColorAppBar,
      this.bodyBgColor, this.onBackPressed})
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
  final Color? bodyBgColor;
  final Function()? onBackPressed;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: true,
      overlayWholeScreen: true,
      overlayWidget: Center(
        child: Image.asset(AppImages.appLogoOnly).w(75).h(75),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        resizeToAvoidBottomInset: true,
        drawerEnableOpenDragGesture: false,
        backgroundColor: widget.bodyBgColor ?? AppColor.primaryColor,
        appBar: widget.withAppBar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: AppBar(
                  backgroundColor: widget.backgroundColorAppBar ?? Colors.white,
                  centerTitle: true,
                  elevation: 0,
                  title: widget.customAppBar
                      ? widget.appBarTitleWidget ??
                          (widget.title ?? 'appbar titlee')
                              .text
                              .color(widget.backgroundColorAppBar == null ? Colors.black : Colors.white)
                              .xl
                              .bold
                              .make()
                      : Image.asset(
                          AppImages.appLogoHorizontal,
                          width: 128,
                        ),
                  leading: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 18,
                    color: widget.backgroundColorAppBar == null ? AppColor.romanSilver : Colors.white,
                  ).w(30).onTap(widget.onBackPressed ?? () => widget.activeContext?.navigator?.pop()),
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
      ),
    );
  }
}
