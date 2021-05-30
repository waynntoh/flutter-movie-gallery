import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movies_gallery/utils/constants.dart';
import 'package:movies_gallery/widgets/clear_inkwell.dart';

class NavBarButton extends StatefulWidget {
  final String text;
  final Function onTap;

  const NavBarButton({Key key, @required this.text, @required this.onTap})
      : super(key: key);

  @override
  _NavBarButtonState createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  bool animate = false;
  double width = 80;

  @override
  Widget build(BuildContext context) {
    return ClearInkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        width: width,
        child: MouseRegion(
          opaque: false,
          onEnter: (event) {
            setState(() {
              animate = true;
            });
          },
          onExit: (event) {
            setState(() {
              animate = false;
            });
          },
          child: Text(
            '${widget.text}',
            style: kOutlinedTextStyle.copyWith(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
