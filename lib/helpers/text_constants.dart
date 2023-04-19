import 'package:flutter/material.dart';

mixin TextConstants {

  TextStyle h1 = const TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0);
  TextStyle h1Alt = const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 20.0, color: Colors.white);

  TextStyle h2 = const TextStyle(
      fontWeight: FontWeight.w300, fontSize: 16.0, color: Colors.white);

  TextStyle defP = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 19.0, color: Color(0xff0b0c0c));

  TextStyle qs = const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 18.0, color: Color(0xff0b0c0c));

  TextStyle as = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 16.0, color: Color(0xff0b0c0c));

  TextStyle newQs = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );
  TextStyle newAs = const TextStyle(
    fontSize: 16.0,
  );

  TextStyle radioTextStyle = const TextStyle(
    fontSize: 16.0,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  TextStyle hint = const TextStyle(
    fontSize: 14.0,
    color: Colors.grey,
    fontStyle: FontStyle.italic,
  );

}