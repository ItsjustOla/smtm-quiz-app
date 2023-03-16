
import 'dart:ui';
import 'package:flutter/material.dart';

class StyleHelper{

  TextStyle h1 = const TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0);
  TextStyle h1Alt = const TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0, color: Colors.white);

  TextStyle h2 = const TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0, color: Colors.white);

  TextStyle defP = const TextStyle(fontWeight: FontWeight.w400, fontSize: 19.0, color: Color(0xff0b0c0c));

  TextStyle qs = const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0, color: Color(0xff0b0c0c));

  TextStyle as = const TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0, color: Color(0xff0b0c0c));

  MaterialColor mycolor = MaterialColor(const Color.fromRGBO(29,112,184, 1).value, <int, Color>{
    50: Color.fromRGBO(29,112,184, 0.1),
    100: Color.fromRGBO(29,112,184, 0.2),
    200: Color.fromRGBO(29,112,184, 0.3),
    300: Color.fromRGBO(29,112,184, 0.4),
    400: Color.fromRGBO(29,112,184, 0.5),
    500: Color.fromRGBO(29,112,184, 0.6),
    600: Color.fromRGBO(29,112,184, 0.7),
    700: Color.fromRGBO(29,112,184, 0.8),
    800: Color.fromRGBO(29,112,184, 0.9),
    900: Color.fromRGBO(29,112,184, 1),
  },
  );

  TextStyle newQs = const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,);
  TextStyle newAs = const TextStyle(fontSize: 16.0,);

}