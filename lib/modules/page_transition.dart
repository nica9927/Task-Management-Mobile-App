import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MyPageTransition {
  CustomTransition get fadeThroughTransition => CustomTransition(
        transitionDuration: Duration(milliseconds: 250),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
            fillColor: Colors.grey[900],
          );
        },
      );

  CustomTransition get sharedAxisTransition => CustomTransition(
        transitionDuration: Duration(milliseconds: 250),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            transitionType: SharedAxisTransitionType.vertical,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
            fillColor: Colors.grey[900],
          );
        },
      );
}
