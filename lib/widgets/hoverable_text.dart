import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_gallery/utils/constants.dart';
import 'package:movies_gallery/utils/movies.dart';
import 'package:movies_gallery/utils/responsive_text_size.dart';

class HoverableText extends StatefulWidget {
  final Movie movie;
  final Function selectMovie;
  final bool highlight;
  final bool disableHover;
  final double responsiveTextSize;

  const HoverableText({
    Key key,
    @required this.movie,
    this.selectMovie,
    this.highlight = false,
    this.disableHover = false,
    this.responsiveTextSize = 6.5,
  }) : super(key: key);

  @override
  HoverableTextState createState() => HoverableTextState();
}

class HoverableTextState extends State<HoverableText> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    if (widget.highlight) setState(() => animate = true);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.disableHover) return _mainComponent(true);

    return Center(
      child: MouseRegion(
        onEnter: (event) => onEnter(),
        onExit: (event) => onExit(),
        onHover: (event) => onHover(),
        child: _mainComponent(false),
      ),
    );
  }

  Widget _mainComponent(bool disableHover) {
    return Container(
      height: double.infinity,
      padding: disableHover ? null : const EdgeInsets.symmetric(horizontal: 56),
      alignment: Alignment.center,
      child: AnimatedDefaultTextStyle(
        child: Text('${widget.movie.title}'),
        style: GoogleFonts.bebasNeue().copyWith(
          fontSize: ResponsiveTextSize.responsiveTextSize(context, 7),
          color: animate ? kWhite80 : Colors.white38,
          letterSpacing: 10,
          shadows: [
            Shadow(
              color: Colors.black87,
              blurRadius: 4,
              offset: Offset(1.5, 1.5),
            ),
            Shadow(
              color: Colors.black87,
              blurRadius: 4,
              offset: Offset(-1.5, -1.5),
            )
          ],
        ),
        duration: Duration(milliseconds: 100),
      ),
    );
  }

  void onEnter() {
    widget.selectMovie(widget.movie);
    setState(() => animate = true);
  }

  void onExit() {
    setState(() => animate = false);
  }

  void onHover() {
    if (animate = true) return;

    setState(() => animate = true);
  }
}
