import 'package:flutter/material.dart';
import 'package:singleton/singleton.dart';
import 'package:rxdart/rxdart.dart';

class AppService {
  //

  static AppService? _instance;
  static AppService? get instance {
    if (_instance == null) {
      _instance = AppService._();
    }

    return _instance;
  }
  /// Factory method that reuse same instance automatically
  // factory AppService() => Singleton.lazy(() => AppService._()).instance;

  /// Private constructor
  AppService._() {}

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BehaviorSubject<int> homePageIndex = BehaviorSubject<int>();

}
