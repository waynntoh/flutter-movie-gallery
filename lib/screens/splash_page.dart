import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_gallery/screens/main_page.dart';
import 'package:movies_gallery/utils/movies.dart';
import 'package:movies_gallery/utils/responsive_text_size.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatefulWidget {
  final Duration splashDuration;

  const SplashPage({Key key, this.splashDuration = const Duration(seconds: 3)})
      : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  CarouselController carouselController = CarouselController();
  Animation<double> animation;
  AnimationController controller;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    animation.removeListener(() {});
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 3, milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          if (animation.isCompleted) {
            Timer(Duration(seconds: 1), () async {
              Navigator.push(
                  context,
                  PageTransition(
                    childCurrent: this.build(context),
                    child: MainPage(
                      resetSplash: resetAnimation,
                    ),
                    type: PageTransitionType.rightToLeftJoined,
                    duration: Duration(seconds: 1, milliseconds: 500),
                    curve: Curves.fastLinearToSlowEaseIn,
                  ));
            });
          }
        });
      });
    controller.forward();
  }

  @override
  void didChangeDependencies() {
    precacheImages();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252525),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 100 * 30,
          child: Opacity(
            opacity: controller.value,
            child: Text(
              '${(controller.value * 100).round()}',
              textAlign: TextAlign.center,
              style: GoogleFonts.bebasNeue().copyWith(
                fontSize: ResponsiveTextSize.responsiveTextSize(context, 12),
                letterSpacing: 10,
                color: Color(0xFFEFEFEF),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void precacheImages() {
    for (Movie m in movies) {
      if (this.mounted) {
        precacheImage(AssetImage(m.image), context);
      }
    }
  }

  void resetAnimation() {
    controller.duration = Duration(seconds: 1);
    controller.reset();
    controller.forward();
  }
}
