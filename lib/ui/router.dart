import 'package:flutter/material.dart';
import 'package:iglo_world/ui/views/help_view.dart';
import 'package:iglo_world/ui/views/home_view.dart';
import 'package:iglo_world/ui/views/login_view.dart';
import 'package:iglo_world/ui/views/splashscreen_view.dart';

const String initialRoute = "login";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'login':
        return _goToLogin();
      case 'splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'issue':
        return MaterialPageRoute(builder: (_) => HelpView());
    /*case 'home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'intro':
        return MaterialPageRoute(builder: (_) => IntroView());
      case 'login':
        return _goToLogin();
      case 'tasklist':
        return MaterialPageRoute(builder: (_) => TaskListView());
      case 'tasklist_detail':
        return MaterialPageRoute(builder: (_) => TaskListDetailView());
      case 'tasklist_process':
        return MaterialPageRoute(builder: (_) => TaskListProcessView());
      case 'add_tasklist':
        return MaterialPageRoute(builder: (_) => TaskListAddView());*/
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}

Route _goToLogin() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => LoginView(),
    transitionDuration: Duration(seconds: 1),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 0.5);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
