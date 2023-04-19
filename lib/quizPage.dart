import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smtm_app/helpers/text_constants.dart';
import 'package:smtm_app/models/QuizModel.dart';
import 'package:smtm_app/widgets/MyAppBar.dart';
import 'package:smtm_app/widgets/MyBottomNav.dart';

import 'helpers/color_constants.dart';
import 'models/QuestionChoice.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TextConstants {
  QuestionChoice _questionSelection = QuestionChoice.all;

  Widget startView(QuizModel model) {
    return myDefaultPadding(Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 100),
          decoration: const BoxDecoration(color: Colors.green),
          child: const Center(
            child: Text('Advert goes here!'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            'Welcome to the UK driving test \'show me, tell me\' practice quiz!',
            style: qs,
          ),
        ),
        Text(
          'Choose the type of questions you\'d like to practice:',
          style: as,
        ),
        ListTile(
          title: Text('All', style: radioTextStyle),
          subtitle:
              Text('Both \'show me\' and \'tell me\' questions.', style: hint),
          leading: Radio<QuestionChoice>(
            value: QuestionChoice.all,
            groupValue: _questionSelection,
            onChanged: (QuestionChoice? value) {
              setState(() {
                _questionSelection = value!;
              });
            },
          ),
          onTap: () {
            setState(() {
              _questionSelection = QuestionChoice.all;
            });
          },
        ),
        const Divider(),
        ListTile(
            title: Text('Tell me', style: radioTextStyle),
            subtitle:
                Text('Explain how to carry out a safety task.', style: hint),
            leading: Radio<QuestionChoice>(
              value: QuestionChoice.tellMe,
              groupValue: _questionSelection,
              onChanged: (QuestionChoice? value) {
                setState(() {
                  _questionSelection = value!;
                });
              },
            ),
            onTap: () {
              setState(() {
                _questionSelection = QuestionChoice.tellMe;
              });
            }),
        const Divider(),
        ListTile(
          title: Text('Show me', style: radioTextStyle),
          subtitle:
              Text('Demonstrate how to carry out a safety task.', style: hint),
          leading: Radio<QuestionChoice>(
            value: QuestionChoice.showMe,
            groupValue: _questionSelection,
            onChanged: (QuestionChoice? value) {
              setState(() {
                _questionSelection = value!;
              });
            },
          ),
          onTap: () {
            setState(() {
              _questionSelection = QuestionChoice.showMe;
            });
          },
        ),
        ElevatedButton(
          onPressed: () {
            model.getQuestions(_questionSelection);
          },
          child: const Text('Start'),
        )
      ],
    ));
  }

  Widget quizView(QuizModel model) {
    return myDefaultPadding(Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // replcae with progress bar
        Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text('Questions: ${model.questionsLength}'),
                Text('Current question: ${model.currentQuestion}'),
              ],
            )),

        Card(
          elevation: 0.0,
          color: Colors.transparent,
          child: FlipCard(
            direction: FlipDirection.VERTICAL,
            side: CardSide.FRONT,
            speed: 750,
            front: Container(
              decoration: BoxDecoration(
                color: ColorConstants().myColor[200],
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Question', style: Theme.of(context).textTheme.titleLarge),
                  Text('Your question here...', style: Theme.of(context).textTheme.bodyMedium),
                  Text('Click here to flip back',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            back: Container(
              decoration: BoxDecoration(
                color: ColorConstants().myColor[200],
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Answer', style: Theme.of(context).textTheme.titleLarge),
                  Text('Your answer goes here...', style: Theme.of(context).textTheme.bodyMedium),
                  Text('Click here to flip front',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ),

        // card goes here
        // const Card(
        //   margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
        //   color: Color(0x00000000),
        //   child: FlipCard(
        //     fill: Fill.fillBack,
        //     front: Text('front'),
        //     back: Text('back'),
        //     speed: 800,
        //   ),
        // ),
        SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                model.previousQuestion();
              },
              child: const Icon(Icons.arrow_back_rounded),
            ),
            ElevatedButton(
              onPressed: () {
                model.resetQuiz();
              },
              child: const Text('Reset quiz'),
            ),
            ElevatedButton(
              onPressed: () {
                model.nextQuestion();
              },
              child: model.isLastQuestion
                  ? const Text('End Quiz')
                  : const Icon(Icons.arrow_forward_rounded),
            )
          ],
        )
      ],
    ));
  }

  Widget endView(QuizModel model) {
    return myDefaultPadding(Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 100),
          decoration: const BoxDecoration(color: Colors.green),
          child: const Center(
            child: Text('Advert goes here!'),
          ),
        ),
        // enhance the text below, maybe add animation and change text and font
        const Text(
            'Congratulations! You have completed the quiz. To take the quiz again, click the \'reset quiz\' button below.'),
        ElevatedButton(
          onPressed: () {
            model.resetQuiz();
          },
          child: const Text('Reset quiz'),
        )
      ],
    ));
  }

  Widget myDefaultPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Quiz!'),
      body: Center(child: Consumer<QuizModel>(
        builder: (context, quiz, child) {
          if (quiz.questionsLength <= 0) {
            return startView(quiz);
          } else if (quiz.currentQuestionIndex == quiz.questionsLength) {
            return endView(quiz);
          } else {
            return quizView(quiz);
          }
        },
      )),
      bottomNavigationBar: const MyBottomNav(
        currentIndex: 1,
      ),
    );
  }
}
