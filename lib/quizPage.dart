import 'package:flutter/material.dart';
import 'package:smtm_app/widgets/MyAppBar.dart';
import 'package:smtm_app/widgets/MyBottomNav.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: 'Quiz!'),
      body: Center(),
      bottomNavigationBar: MyBottomNav(currentIndex: 1,),
    );
  }
}
