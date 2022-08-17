import 'package:read_novel/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:read_novel/views/pages/auth/login.page.dart';
import 'package:read_novel/views/pages/auth/register.page.dart';
import 'package:read_novel/views/pages/home.page.dart';
import 'package:read_novel/views/pages/menulis/register_penulis.page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    case AppRoutes.loginRoute:
      return MaterialPageRoute(builder: (context) => const LoginPage());

    case AppRoutes.registerRoute:
      return MaterialPageRoute(builder: (context) => const RegisterPage());

    case AppRoutes.homeRoute:
      return MaterialPageRoute(builder: (context) => const HomePage());

    case AppRoutes.registerWriterRoute:
      return MaterialPageRoute(builder: (context) => const RegisterPenulisPage());

    //
    // case AppRoutes.laporanPenjualan:
    //   return MaterialPageRoute(
    //     settings: const RouteSettings(name: AppRoutes.laporanPenjualan),
    //     builder: (context) => const LaporanPenjualanPage(),
    //   );

    // case AppRoutes.laporanPenjualanTransaksiAll:
    //   return MaterialPageRoute(
    //     settings: const RouteSettings(name: AppRoutes.laporanPenjualanTransaksiAll, arguments: <String, dynamic>{}),
    //     builder: (context) => LaporanPenjualanAllTransaksiPage(vm: settings.arguments!['vm']),
    //   );

    // case AppRoutes.laporanPenjualanReturAll:
    //   return MaterialPageRoute(
    //     settings: const RouteSettings(name: AppRoutes.laporanPenjualanReturAll),
    //     builder: (context) => const LaporanPenjualanPage(),
    //   );

    default:
      return MaterialPageRoute(builder: (context) => const HomePage());
  }
}
