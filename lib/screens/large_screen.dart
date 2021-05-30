import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:movies_gallery/utils/constants.dart';
import 'package:movies_gallery/utils/movies.dart';
import 'package:movies_gallery/widgets/contact_dialog.dart';
import 'package:movies_gallery/widgets/dialog_animation.dart';
import 'package:movies_gallery/widgets/hoverable_text.dart';
import 'package:movies_gallery/widgets/navbar_button.dart';

class LargeScreen extends StatefulWidget {
  final Size size;
  final List<Widget> children;
  final Function resetSplash;

  const LargeScreen({
    Key key,
    @required this.size,
    @required this.resetSplash,
    this.children = const [],
  }) : super(key: key);

  @override
  _LargeScreenState createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  Size size;
  double cursorSize = 40;
  double enlargedCursorSize = 80;

  Offset pointerOffset;

  bool animateCursor = false;
  bool animateFollowMe = false;
  bool initialHoverDisabled = true;
  bool loading = false;

  Movie selectedMovie = movies[0];
  CarouselController carouselController = new CarouselController();

  @override
  void initState() {
    super.initState();
    pointerOffset = Offset(widget.size.width / 2, widget.size.height / 2);

    Timer(Duration(milliseconds: 500),
        () => setState(() => initialHoverDisabled = false));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return IgnorePointer(
      ignoring: initialHoverDisabled,
      child: Stack(
        children: [
          // # Carousel
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
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
              padding: const EdgeInsets.all(56),
              child: Row(
                children: [
                  customCursorArea(
                    onEnter: (event) => toggleCursorAnimation(true),
                    onExit: (event) => toggleCursorAnimation(false),
                    child: TextButton(
                      onPressed: () => refresh(),
                      child: Text(
                        'Flutter Web',
                        style: kOutlinedTextStyle.copyWith(fontSize: 21),
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      customCursorArea(
                        onEnter: (event) => toggleCursorAnimation(true),
                        onExit: (event) => toggleCursorAnimation(false),
                        child: NavBarButton(
                          text: 'Home',
                          onTap: () => refresh(),
                        ),
                      ),
                      customCursorArea(
                        onEnter: (event) => toggleCursorAnimation(true),
                        onExit: (event) => toggleCursorAnimation(false),
                        child: NavBarButton(
                          text: 'Contact',
                          onTap: () => _showDialog(),
                        ),
                      ),
                    ],
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
              padding: const EdgeInsets.all(56),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 360,
                        child: Text(
                          '${selectedMovie.description}',
                          maxLines: 20,
                          style: kOutlinedTextStyle.copyWith(
                            fontWeight: FontWeight.normal,
                            color: kWhite80,
                            fontSize: 12,
                            height: 2,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 32),
                      Row(
                        children: [
                          SizedBox(
                            height: 35,
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
                            height: 35,
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
                  SizedBox(
                    height: 35,
                    child: Row(
                      children: [
                        Text(
                          'Powered by Github',
                          style: kOutlinedTextStyle.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(width: 16),
                        IconShadowWidget(
                          Icon(
                            Icons.power_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                          showShadow: true,
                          shadowColor: Colors.black54,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          MouseRegion(
            opaque: false,
            onHover: (event) => updatePosition(event.position),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            curve: Curves.fastLinearToSlowEaseIn,
            left: animateCursor
                ? pointerOffset.dx - enlargedCursorSize / 2
                : pointerOffset.dx - cursorSize / 2,
            top: animateCursor
                ? pointerOffset.dy - enlargedCursorSize / 2
                : pointerOffset.dy - cursorSize / 2,
            child: cursor(),
          ),
        ],
      ),
    );
  }

  Widget cursor() {
    return MouseRegion(
      opaque: false,
      child: AnimatedContainer(
        child: loading
            ? SpinKitDualRing(
                color: Colors.white70,
              )
            : SizedBox.shrink(),
        duration: Duration(milliseconds: 250),
        width: animateCursor ? enlargedCursorSize : cursorSize,
        height: animateCursor ? enlargedCursorSize : cursorSize,
        decoration: BoxDecoration(
          border: Border.all(
            color: animateCursor ? Colors.transparent : Colors.white70,
            width: 2,
          ),
          color: animateCursor ? Colors.white54 : Colors.transparent,
          borderRadius: BorderRadius.circular(90),
        ),
      ),
    );
  }

  _showDialog() {
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

  Widget customCursorArea({Function onEnter, Function onExit, Widget child}) {
    return MouseRegion(
      opaque: false,
      onEnter: onEnter,
      onExit: onExit,
      child: child,
    );
  }

  void updatePosition(Offset offset) {
    setState(() => pointerOffset = offset);
  }

  void toggleCursorAnimation(bool b) {
    setState(() => animateCursor = b);
  }

  void toggleFollowMeAnimation(bool b) {
    setState(() => animateFollowMe = b);
  }

  void selectMovie(Movie p) {
    setState(() => selectedMovie = p);
    carouselController.animateToPage(int.parse(p.index) - 1);
  }

  void carouselChangePage(int index) {
    setState(() => selectedMovie = movies[index]);
    carouselController.animateToPage(index);
  }

  void toggleLoaderAnimation() => setState(() => loading = !loading);

  void refresh() {
    setState(() => toggleLoaderAnimation());

    Timer(Duration(seconds: 1, milliseconds: 500), () {
      toggleLoaderAnimation();
      widget.resetSplash();
      Navigator.pop(context);
    });
  }

  CarouselOptions carouselOption(bool isMain) {
    return CarouselOptions(
      autoPlay: true,
      pauseAutoPlayOnManualNavigate: true,
      pauseAutoPlayOnTouch: true,
      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
      autoPlayAnimationDuration: Duration(milliseconds: 1500),
      autoPlayInterval: Duration(seconds: 7),
      viewportFraction: isMain ? .5 : .8,
      onPageChanged: (index, reason) =>
          isMain ? carouselChangePage(index) : null,
      scrollDirection: isMain ? Axis.horizontal : Axis.vertical,
      reverse: isMain ? false : true,
    );
  }

  List<Widget> hoverableTexts() => movies
      .map((e) => e.index == selectedMovie.index
          ? HoverableText(movie: e, selectMovie: selectMovie, highlight: true)
          : HoverableText(movie: e, selectMovie: selectMovie))
      .toList();

  List<Widget> indexNumbers() => movies
      .map((e) => Text('0${e.index}',
          textAlign: TextAlign.center,
          style: kOutlinedTextStyle.copyWith(
            fontWeight: FontWeight.normal,
          )))
      .toList();
}
