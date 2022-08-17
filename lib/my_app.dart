import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:read_novel/constants/app_strings.dart';
import 'package:read_novel/constants/app_theme.dart';
import 'package:read_novel/services/routers.services.dart' as router;
import 'package:read_novel/views/pages/home.page.dart';
import 'package:read_novel/views/pages/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
            theme: theme,
            home: const SplashScreen(),
          );
        }
    );
  }
}
