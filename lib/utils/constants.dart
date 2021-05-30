import 'package:flutter/material.dart';

const kOutlinedTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 14,
  shadows: kTextShadow,
);

const kTextShadow = [
  Shadow(
    color: Colors.black87,
    blurRadius: 2,
    offset: Offset(1.5, 1.5),
  ),
  Shadow(
    color: Colors.black87,
    blurRadius: 2,
    offset: Offset(-1.5, -1.5),
  )
];

const kWhite80 = Color(0xCCFFFFFF);
