import 'package:flutter/material.dart';
import 'package:whatsappclone/pages/registrationPage.dart';
import 'package:whatsappclone/pages/welcomePage.dart';
import 'package:whatsappclone/routeGenerator/routeErrorPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (context) => WelcomePage());
      case RegistrationPage.routeName:
        return MaterialPageRoute(
          builder: (context) => RegistrationPage(),
        );
      default:
        _errorRoute();
        break;
    }
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) => RouteErrorPage());
  }
}