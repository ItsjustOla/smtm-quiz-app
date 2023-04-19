import 'package:flutter/material.dart';
import 'package:smtm_app/helpers/text_constants.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _MyAppBarState extends State<MyAppBar> with TextConstants {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        widget.title,
        style: h1,
      ),
    );
  }
}
