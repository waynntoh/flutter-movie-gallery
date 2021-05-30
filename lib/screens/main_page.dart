import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movies_gallery/screens/large_screen.dart';
import 'package:movies_gallery/screens/small_screen.dart';
import 'package:movies_gallery/utils/responsive_layout.dart';

class MainPage extends StatefulWidget {
  final Function resetSplash;

  const MainPage({Key key, @required this.resetSplash}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: ResponsiveLayout(
        largeScreen: LargeScreen(
          size: size,
          resetSplash: widget.resetSplash,
        ),
        mediumScreen: SmallScreen(
          resetSplash: widget.resetSplash,
        ),
        smallScreen: SmallScreen(
          resetSplash: widget.resetSplash,
        ),
      ),
    );
  }
}
