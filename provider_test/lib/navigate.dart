//命名路由
import 'package:flutter/material.dart';
import 'package:provider_test/test_page_one.dart';
import 'package:provider_test/test_page_two.dart';
import 'home_page.dart';

enum NavigateRoute { root, one, two }

extension NavigateRouteName on NavigateRoute {
  String get name {
    switch (this) {
      case NavigateRoute.root:
        return '/';
      default:
        return toString().split('.').last;
    }
  }
}

class YYNavigator {
  //routes config
  static Map<String, WidgetBuilder> routes = {
    NavigateRoute.root.name: (context) => HomePage1(),
    NavigateRoute.one.name: (context) => const TestPageOnePage(),
    NavigateRoute.two.name: (context) => const TestPageTwoPage(),
  };
}

Object? navigatorArguments(BuildContext context) {
  return ModalRoute.of(context)?.settings.arguments;
}

extension Presenter on Navigator {
  static Future<T?> push<T extends Object?>(BuildContext context, NavigateRoute route, {Object? arguments}) {
    return Navigator.pushNamed(context, route.name, arguments: arguments);
  }

  static void pop<T extends Object?>(BuildContext context) {
    Navigator.pop(context);
  }
}
