import 'package:flutter/cupertino.dart';

class NavigatorManager {
  static void pushFadeTransition(
      {required BuildContext context, required Widget page}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return page;
        },
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.bounceIn);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  static void pushSliderTransition(
      {required BuildContext context, required Widget page}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return page;
        },
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.bounceIn);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  static void pushAndRemoveFadeTransition(
      {required BuildContext context, required Widget page}) {
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return page;
          },
          transitionDuration: const Duration(milliseconds: 5000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.bounceIn);
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        ((route) => false));
  }
}
