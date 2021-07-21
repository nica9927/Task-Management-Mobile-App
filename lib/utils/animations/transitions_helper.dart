import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

abstract class TransitionsHelper {
  static Widget sharedAxisTransition(Widget child, Animation<double> primaryAnimation, Animation<double> secondaryAnimation) {
    return SharedAxisTransition(
      animation: primaryAnimation,
      secondaryAnimation: secondaryAnimation,
      child: child,
      fillColor: Colors.transparent,
      transitionType: SharedAxisTransitionType.horizontal,
    );
  }

  static Widget sharedAxisTransitionVertical(Widget child, Animation<double> primaryAnimation, Animation<double> secondaryAnimation) {
    return SharedAxisTransition(
      animation: primaryAnimation,
      secondaryAnimation: secondaryAnimation,
      child: child,
      fillColor: Colors.transparent,
      transitionType: SharedAxisTransitionType.vertical,
    );
  }

  static Widget fadeThroughTransition(Widget child, Animation<double> primaryAnimation, Animation<double> secondaryAnimation) {
    return FadeThroughTransition(
      animation: primaryAnimation,
      secondaryAnimation: secondaryAnimation,
      child: child,
      fillColor: Colors.transparent,
    );
  }

  static Widget sizeTransition(Widget child, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: child,
    );
  }

  static Widget sizeTransitionHorizontal(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        axis: Axis.horizontal,
        axisAlignment: 1,
        child: child,
      ),
    );
  }

  static Widget fadeTransition(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
