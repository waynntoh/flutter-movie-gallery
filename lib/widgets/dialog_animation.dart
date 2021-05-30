import 'package:flutter/material.dart';

class DialogAnimation {
  // slide animation with grow effect
  static grow(Animation<double> _animation,
      Animation<double> _secondaryAnimation, Widget _child) {
    return ScaleTransition(
      child: _child,
      scale: Tween<double>(end: 1.0, begin: 0.0).animate(CurvedAnimation(
          parent: _animation,
          curve: Interval(0.00, 0.50, curve: Curves.linear))),
    );
  }

  // slide animation with shrink effect
  static shrink(Animation<double> _animation,
      Animation<double> _secondaryAnimation, Widget _child) {
    return ScaleTransition(
      child: _child,
      scale: Tween<double>(end: 1.0, begin: 1.2).animate(CurvedAnimation(
          parent: _animation,
          curve: Interval(0.50, 1.00, curve: Curves.fastLinearToSlowEaseIn))),
    );
  }
}
