import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prima_studio/config/routing/arguments/profile/account_setting_args.dart';
import 'package:prima_studio/ui/pages/pages.dart';
import 'package:prima_studio/ui/splash_screen.dart';
import 'package:transition/transition.dart';
import './arguments/arguments.dart';

class AppRouter {
  Route onRoute(RouteSettings settings) {
    log('Route: ${settings.name}');
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      // case "/":
      //   return MaterialPageRoute(
      //     builder: (context) => const TestSearchPage(),
      //   );

      // Module Auth
      case "/auth-login":
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => const LoginPage(),
        );
      case "/auth-regis":
        return Transition(
          transitionEffect: TransitionEffect.RIGHT_TO_LEFT,
          child: const RegisterPage(),
        );
      case "/auth-verif":
      case "/auth-forgot":

      // Module Menu
      case "/menu":
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => const MenuPage(),
        );

      // - Film
      case "/film-all":
        final args = settings.arguments as FilmAllArguments;
        return MaterialPageRoute(
          builder: (context) => AllPage(
            film: args.film,
            isComingSoon: args.isComingSoon,
          ),
        );
      case "/film-detail":
        final args = settings.arguments as FilmDetailArguments;
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => DetailPage(
            heroTag: args.bannerTag,
            // ignore: unnecessary_null_in_if_null_operators
            fabTag: args.fabTag ?? null,
            isComingSoon: args.isComingSoon,
            film: args.film,
          ),
        );
      case "/film-video":
        final args = settings.arguments as FilmVideoArguments;
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) => VideoPage(
            heroTag: args.bannerTag,
            film: args.film,
          ),
        );

      // - Profile
      case "/profile-account":
        final args = settings.arguments as AccountSettingArguments;
        return Transition(
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          child: AccountSettingPage(
            user: args.user,
          ),
        );
      case "/profile-chat":
        return Transition(
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          child: const ChatPage(),
        );
      case "/profile-notif":

      // - Search
      case "/search":

      // Module Events
      case "/event":
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text(
            '404 Not Found',
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}
