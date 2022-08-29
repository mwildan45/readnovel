import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:read_novel/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:read_novel/services/auth.service.dart';
import 'package:read_novel/services/local_storage.service.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await LocalStorageService.getPrefs();
      await initialize();
      final token = await AuthServices.getAuthBearerToken();
      print('TOKEN: $token');

      //prevent ssl error
      HttpOverrides.global = MyHttpOverrides();
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      await initializeDateFormatting('id_ID', null).then((_) => runApp(const MyApp()));
    },
    (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
