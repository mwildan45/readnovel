import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:read_novel/constants/app_theme.dart';
import 'package:read_novel/services/routers.services.dart' as router;
import 'package:read_novel/utils/GlobalVariable.dart';
import 'package:read_novel/views/pages/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.link}) : super(key: key);
  final PendingDynamicLinkData? link;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: AppTheme().lightTheme(),
        initial: AdaptiveThemeMode.system,
        builder: (theme, darkTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            onGenerateRoute: router.generateRoute,
            navigatorKey: GlobalVariable.navState,
            theme: theme,
            home: SplashScreen(link: link),
          );
        }
    );
  }
}
