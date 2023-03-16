import 'package:flutter/material.dart';
import 'package:smtm_app/widgets/MyAppBar.dart';
import 'package:smtm_app/widgets/MyBottomNav.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: 'Settings'),
      body: Center(),
      bottomNavigationBar: MyBottomNav(currentIndex: 2,),
    );
  }
}
