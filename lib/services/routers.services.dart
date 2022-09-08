import 'package:read_novel/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/view_models/register_as_writer.vm.dart';
import 'package:read_novel/view_models/write_novel.vm.dart';
import 'package:read_novel/views/pages/auth/login.page.dart';
import 'package:read_novel/views/pages/auth/register.page.dart';
import 'package:read_novel/views/pages/dashboard/see_all.page.dart';
import 'package:read_novel/views/pages/home.page.dart';
import 'package:read_novel/views/pages/menulis/menulis_novel/create_update_novel.page.dart';
import 'package:read_novel/views/pages/menulis/menulis_novel/list_my_novel_chapter.page.dart';
import 'package:read_novel/views/pages/menulis/menulis_novel/update_novel.page.dart';
import 'package:read_novel/views/pages/menulis/menulis_novel/write_chapter.page.dart';
import 'package:read_novel/views/pages/menulis/register_as_writer.page.dart';
import 'package:read_novel/views/pages/menulis/register_step/confirm_data.page.dart';
import 'package:read_novel/views/pages/payment.page.dart';
import 'package:read_novel/views/pages/profile/koinku.page.dart';
import 'package:read_novel/views/pages/profile/pusat_bantuan.page.dart';
import 'package:read_novel/views/pages/read_novel/detail_novel.page.dart';
import 'package:read_novel/views/pages/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    case AppRoutes.splashScreenRoute:
      return MaterialPageRoute(builder: (context) => const SplashScreen());

    case AppRoutes.loginRoute:
      return MaterialPageRoute(builder: (context) => const LoginPage());

    case AppRoutes.registerRoute:
      return MaterialPageRoute(builder: (context) => const RegisterPage());

    case AppRoutes.homeRoute:
      return MaterialPageRoute(builder: (context) => const HomePage());

    case AppRoutes.seeAllRoute:
      return MaterialPageRoute(
        settings:
        const RouteSettings(name: AppRoutes.seeAllRoute),
        builder: (context) => SeeAllNovelsSectionPage(
          sectionName: settings.arguments as String,
        ),
      );

    case AppRoutes.registerWriterRoute:
      return MaterialPageRoute(
          builder: (context) => const RegisterAsWriterPage());

    case AppRoutes.confirmRegisterWriterRoute:
      return MaterialPageRoute(
        settings:
            const RouteSettings(name: AppRoutes.confirmRegisterWriterRoute),
        builder: (context) => ConfirmDataWriterPage(
          vm: settings.arguments as RegisterAsWriterViewModel,
        ),
      );

    case AppRoutes.createNovelRoute:
      return MaterialPageRoute(builder: (context) => const CreateNovelPage());

    case AppRoutes.updateNovelRoute:
      return MaterialPageRoute(
        settings: const RouteSettings(name: AppRoutes.updateNovelRoute),
        builder: (context) => UpdateNovelPage(
          idNovel: settings.arguments as int,
        ),
      );

    case AppRoutes.writeChapterRoute:
      return MaterialPageRoute(
        settings: const RouteSettings(name: AppRoutes.writeChapterRoute),
        builder: (context) => WriteChapterPage(
          data: settings.arguments as Map,
        ),
      );

    case AppRoutes.listChapterRoute:
      return MaterialPageRoute(
        settings: const RouteSettings(name: AppRoutes.listChapterRoute),
        builder: (context) => ListMyNovelChapter(
          idNovel: settings.arguments as int,
        ),
      );

    case AppRoutes.detailNovelRoute:
      return MaterialPageRoute(
        settings: const RouteSettings(name: AppRoutes.detailNovelRoute),
        builder: (context) => DetailNovelPage(
          novel: settings.arguments as Novel,
        ),
      );

    // case AppRoutes.readNovelRoute:
    //   return MaterialPageRoute(
    //     settings: const RouteSettings(name: AppRoutes.readNovelRoute),
    //     builder: (context) => ReadNovelChapterPage(
    //       chapters: settings.arguments as Chapters,
    //       detailNovel: ,
    //     ),
    //   );

    case AppRoutes.faqRoute:
      return MaterialPageRoute(builder: (context) => const PusatBantuanPage());

    case AppRoutes.koinkuRoute:
      return MaterialPageRoute(builder: (context) => const KoinkuPage());

    case AppRoutes.paymentWebView:
      return MaterialPageRoute(
        settings: const RouteSettings(name: AppRoutes.paymentWebView),
        builder: (context) => PaymentScreen(
          url: settings.arguments as String,
        ),
      );


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
