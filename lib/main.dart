
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smtm_app/models/QuizModel.dart';
import 'package:smtm_app/quizPage.dart';
import 'package:smtm_app/settingsPage.dart';
import 'package:smtm_app/widgets/expandable_card_container.dart';
import 'package:smtm_app/widgets/my_alert_dialog.dart';
import 'helpers/questions_helper.dart';
import 'models/questions.dart';
import 'helpers/style_helper.dart';
import 'widgets/MyAppBar.dart';
import 'widgets/MyBottomNav.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: StyleHelper().mycolor,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(),
          '/quiz': (context) => const QuizPage(),
          '/settings': (context) => const SettingsPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<bool> _isOpen1 = List<bool>.filled(14, false);
  final List<bool> _isOpen2 = List<bool>.filled(7, false);

  Widget _expansionList(List<QaPair> pairs, List<bool> isOpenList) {
    debugPrint('Creating expansion list');
    // return ExpansionPanelList(
    //   children: pairs.mapIndexed<ExpansionPanel>((int index, QaPair pair) {
    //     debugPrint('current index $index - isOpen ${isOpenList[index]}');
    //     return ExpansionPanel(
    //         headerBuilder: (BuildContext context, bool isExpanded) {
    //           return ListTile(
    //             title: Text(
    //               'Q${index + 1}). ${pair.question}',
    //               style: StyleHelper().qs,
    //             ),
    //           );
    //         },
    //         body: ListTile(
    //           title: Text('A. ${pair.answer}', style: StyleHelper().as),
    //         ),
    //         isExpanded: isOpenList[index]);
    //   }).toList(),
    //   expansionCallback: (int index, bool isOpen) {
    //     setState(() {
    //       isOpenList[index] = !isOpen;
    //     });
    //   },
    // );

    return Column(
      children: pairs
          .mapIndexed<ExpandableCardContainer>(
              (int index, QaPair pair) => ExpandableCardContainer(
                isExpanded: isOpenList[index],
                header: 'Question ${index+1}',
                collapsedChild: Text(
                  pair.question,
                  style: StyleHelper().newQs,
                ),
                expandedChild: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      pair.question,
                      style: StyleHelper().newQs,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      pair.answer,
                      style: StyleHelper().newAs,
                    )
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _homeBody() {
    return FutureBuilder<AllQuestions>(
      future: QuestionsHelper().getQuestions(),
      builder: (context, AsyncSnapshot<AllQuestions> snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text('Unexpected Error. Please try again later.'));
        }
        if (snapshot.hasData) {
          AllQuestions data = snapshot.data!;
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyAlertDialog().getDialog(context),
                  const SizedBox(height: 12),
                  Text('${data.tmQuestions.qaPair.length} - Tell Me Questions ',
                      style: StyleHelper().h1
                  ),
                  const SizedBox(height: 12),
                  _expansionList(data.tmQuestions.qaPair, _isOpen1),
                  const SizedBox(height: 12),
                  Text('${data.smQuestions.qaPair.length} - Show Me Questions ',
                      style: StyleHelper().h1
                  ),
                  const SizedBox(height: 12),
                  _expansionList(data.smQuestions.qaPair, _isOpen2)
                ],
              ),
            ),
          );
        }
        return Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Getting questions, sit tight!')
          ],
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Show Me Tell Me'),
      body: _homeBody(),
      bottomNavigationBar: const MyBottomNav(
        currentIndex: 0,
      ),
    );
  }
}
