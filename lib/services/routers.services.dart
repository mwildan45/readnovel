import 'package:read_novel/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:read_novel/models/novel.model.dart';
import 'package:read_novel/view_models/register_as_writer.vm.dart';
import 'package:read_novel/view_models/write_novel.vm.dart';
import 'package:read_novel/views/pages/auth/login.page.dart';
import 'package:read_novel/views/pages/auth/register.page.dart';
import 'package:read_novel/views/pages/author/author.page.dart';
import 'package:read_novel/views/pages/dashboard/see_all_authors.page.dart';
import 'package:read_novel/views/pages/dashboard/see_all_novels.page.dart';
import 'package:read_novel/views/pages/home.page.dart';
import 'package:read_novel/views/pages/menulis/income.page.dart';
import 'package:read_novel/views/pages/menulis/menulis_novel/create_update_novel.page.dart';
import 'package:read_novel/views/pages/menulis/menulis_novel/list_my_novel_chapters.page.dart';
import 'package:read_novel/views/pages/menulis/menulis_novel/update_novel.page.dart';
import 'package:read_novel/views/pages/menulis/menulis_novel/write_chapter.page.dart';
import 'package:read_novel/views/pages/menulis/register_as_writer.page.dart';
import 'package:read_novel/views/pages/menulis/register_step/confirm_data.page.dart';
import 'package:read_novel/views/pages/payment.page.dart';
import 'package:read_novel/views/pages/profile/edit_profile.page.dart';
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

    case AppRoutes.seeAllNovelsRoute:
      return MaterialPageRoute(
        settings:
        const RouteSettings(name: AppRoutes.seeAllNovelsRoute),
        builder: (context) => SeeAllNovelsSectionPage(
          map: settings.arguments as Map,
        ),
      );

    case AppRoutes.seeAllAuthorsRoute:
      return MaterialPageRoute(builder: (context) => const SeeAllAuthorsSectionPage());

    case AppRoutes.authorDetail:
      return MaterialPageRoute(
        settings: const RouteSettings(name: AppRoutes.authorDetail),
        builder: (context) => AuthorDetailPage(
          idAuthor: settings.arguments as int,
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

    case AppRoutes.incomeAuthor:
      return MaterialPageRoute(
        // settings:
        //     const RouteSettings(name: AppRoutes.incomeAuthor),
        builder: (context) => IncomePage(
          // map: settings.arguments as Map,
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
        builder: (context) => ListMyNovelChapters(
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

    case AppRoutes.editProfile:
      return MaterialPageRoute(builder: (context) => const EditProfilePage());

    case AppRoutes.paymentWebView:
      return MaterialPageRoute(
        settings: const RouteSettings(name: AppRoutes.paymentWebView),
        builder: (context) => PaymentScreen(
          url: settings.arguments as String,
        ),
      );

    default:
      return MaterialPageRoute(builder: (context) => const HomePage());
  }
}
