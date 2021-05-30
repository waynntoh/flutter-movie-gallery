import 'package:flutter/material.dart';

class ClearInkWell extends StatelessWidget {
  final Widget child;
  final Function onTap;

  const ClearInkWell({Key key, this.onTap, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: child,
      onTap: onTap,
    );
  }
}
