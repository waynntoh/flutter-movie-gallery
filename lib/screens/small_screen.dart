import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:movies_gallery/utils/constants.dart';
import 'package:movies_gallery/utils/movies.dart';
import 'package:movies_gallery/utils/responsive_layout.dart';
import 'package:movies_gallery/utils/responsive_text_size.dart';
import 'package:movies_gallery/widgets/clear_inkwell.dart';
import 'package:movies_gallery/widgets/contact_dialog.dart';
import 'package:movies_gallery/widgets/dialog_animation.dart';
import 'package:movies_gallery/widgets/hoverable_text.dart';

class SmallScreen extends StatefulWidget {
  final Function resetSplash;

  const SmallScreen({Key key, @required this.resetSplash}) : super(key: key);

  @override
  _SmallScreenState createState() => _SmallScreenState();
}

class _SmallScreenState extends State<SmallScreen> {
  CarouselController carouselController = CarouselController();
  Movie selectedMovie = movies[0];

  bool droppedDown = false;
  bool loading = false;

  List<Widget> carouselTitles;

  @override
  void initState() {
    super.initState();
    carouselTitles = hoverableTexts();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // # Carousel
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(selectedMovie.image),
              ),
            ),
            child: CarouselSlider(
              carouselController: carouselController,
              items: hoverableTexts(),
              options: carouselOption(true),
            ),
          ),
          // # Nav Bar
          Positioned(
            width: size.width,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => refresh(),
                    child: Text(
                      'Flutter Web',
                      style: kOutlinedTextStyle.copyWith(
                        fontSize: ResponsiveLayout.isMediumScreen(context)
                            ? 21
                            : ResponsiveTextSize.responsiveTextSize(context, 3),
                      ),
                    ),
                  ),
                  Spacer(),
                  ClearInkWell(
                    onTap: () => toggleNavbarButtons(),
                    child: IconShadowWidget(
                      Icon(
                        droppedDown ? Icons.close_rounded : Icons.menu_rounded,
                        color: Colors.white,
                        size: 27,
                      ),
                      showShadow: true,
                      shadowColor: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // # Footer
          Positioned(
            bottom: 0,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: size.width / 2,
                        child: Text(
                          '${selectedMovie.description}',
                          maxLines: 20,
                          style: kOutlinedTextStyle.copyWith(
                            fontWeight: FontWeight.normal,
                            color: kWhite80,
                            fontSize: 11,
                            height: 2,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 30,
                            child: IgnorePointer(
                              ignoring: true,
                              child: CarouselSlider(
                                carouselController: carouselController,
                                items: indexNumbers(),
                                options: carouselOption(false),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 45,
                            child: Column(
                              children: [
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 1,
                                  height: 1,
                                  color: Colors.black38,
                                ),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 1,
                                  height: 1,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 30,
                            child: Center(
                              child: Text(
                                '0${movies.length}',
                                style: kOutlinedTextStyle.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        'Powered by Github',
                        style: kOutlinedTextStyle.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: ResponsiveLayout.isMediumScreen(context)
                              ? 14
                              : 12,
                        ),
                      ),
                      SizedBox(width: 16),
                      SizedBox(
                        height: 40,
                        width: 30,
                        child: IconShadowWidget(
                          Icon(
                            Icons.power_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                          showShadow: true,
                          shadowColor: Colors.black54,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          // # Navbar Buttons
          Positioned(
            top: 100,
            child: AnimatedContainer(
              padding:
                  droppedDown ? const EdgeInsets.symmetric(vertical: 24) : null,
              duration: Duration(milliseconds: 100),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.black54,
                border: droppedDown
                    ? Border.all(
                        color: Colors.black87,
                        width: .5,
                      )
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 1,
                    offset: Offset(-1, 0),
                  ),
                ],
              ),
              child: droppedDown
                  ? Column(
                      children: [
                        navbarDropdownButton('Home', () => refresh()),
                        navbarDropdownButton('Contact', () => _showDialog()),
                      ],
                    )
                  : SizedBox.shrink(),
            ),
          ),
          loading
              ? Center(
                  child: SpinKitDualRing(
                    color: Colors.white70,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  _showDialog() {
    setState(() => droppedDown = false);
    return showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 150),
      transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
        return DialogAnimation.shrink(_animation, _secondaryAnimation, _child);
      },
      pageBuilder: (_animation, _secondaryAnimation, _child) {
        return ContactDialog();
      },
    );
  }

  void toggleLoaderAnimation() => setState(() => loading = !loading);

  void refresh() {
    setState(() {
      droppedDown = false;
      toggleLoaderAnimation();
    });

    Timer(Duration(seconds: 1, milliseconds: 500), () {
      toggleLoaderAnimation();
      widget.resetSplash();
      Navigator.pop(context);
    });
  }

  void carouselChangePage(int index) {
    setState(() => selectedMovie = movies[index]);
    carouselController.animateToPage(index);
  }

  void selectMovie(Movie p) {
    setState(() => selectedMovie = p);
    carouselController.animateToPage(int.parse(p.index) - 1);
  }

  void toggleNavbarButtons() {
    setState(() => setState(() => droppedDown = !droppedDown));
  }

  CarouselOptions carouselOption(bool isMain) {
    return CarouselOptions(
      height: isMain ? double.infinity : 50,
      autoPlay: true,
      pauseAutoPlayOnManualNavigate: true,
      pauseAutoPlayOnTouch: true,
      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
      autoPlayAnimationDuration: Duration(milliseconds: 1500),
      autoPlayInterval: Duration(seconds: 7),
      viewportFraction: .8,
      onPageChanged: (index, reason) =>
          isMain ? carouselChangePage(index) : null,
      scrollDirection: isMain ? Axis.horizontal : Axis.vertical,
      reverse: isMain ? false : true,
    );
  }

  List<Widget> hoverableTexts() => movies
      .map((e) => HoverableText(
            movie: e,
            selectMovie: selectMovie,
            highlight: true,
            disableHover: true,
            responsiveTextSize: 9,
          ))
      .toList();

  List<Widget> indexNumbers() => movies
      .map((e) => Text('0${e.index}',
          textAlign: TextAlign.center,
          style: kOutlinedTextStyle.copyWith(
            fontWeight: FontWeight.normal,
          )))
      .toList();

  Widget navbarDropdownButton(String text, Function onTap) {
    return ClearInkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        alignment: Alignment.centerLeft,
        child: Text(
          '$text',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
