import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smtm_app/helpers/style_helper.dart';
import 'package:smtm_app/models/QuizModel.dart';
import 'package:smtm_app/widgets/MyAppBar.dart';
import 'package:smtm_app/widgets/MyBottomNav.dart';

import 'models/QuestionChoice.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  QuestionChoice _questionSelection = QuestionChoice.all;

  Widget startView(QuizModel model) {
    return myDefaultPadding(Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 100),
          decoration: const BoxDecoration(color: Colors.green),
          child: const Center(
            child: Text('Advert goes here!'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            'Welcome to the UK driving test \'show me, tell me\' practice quiz!',
            style: StyleHelper().qs,
          ),
        ),
        SizedBox(
          height: 35,
          child: Text(
            'Choose the type of questions you\'d like to practice:',
            style: StyleHelper().as,),
        ),
        ListTile(
            title: StyleHelper().buildRichText('All', 'both \'show me\' and \'tell me\' questions.'),
            leading: Radio<QuestionChoice>(
              value: QuestionChoice.all,
              groupValue: _questionSelection,
              onChanged: (QuestionChoice? value) {
                setState(() {
                  _questionSelection = value!;
                });
              },
            )),
        ListTile(
            title: StyleHelper().buildRichText('Tell me', ' explain how to carry out a safety task.'),
            leading: Radio<QuestionChoice>(
              value: QuestionChoice.tellMe,
              groupValue: _questionSelection,
              onChanged: (QuestionChoice? value) {
                setState(() {
                  _questionSelection = value!;
                });
              },
            )),
        ListTile(
            title: StyleHelper().buildRichText('Show me', 'demonstrate how to carry out a safety task.'),
            leading: Radio<QuestionChoice>(
              value: QuestionChoice.showMe,
              groupValue: _questionSelection,
              onChanged: (QuestionChoice? value) {
                setState(() {
                  _questionSelection = value!;
                });
              },
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {
                model.getQuestions(_questionSelection);
              },
              child: const Text('Start'),
            ),
          ),
        )
      ],
    ));
  }

  Widget quizView(QuizModel model) {
    return myDefaultPadding(Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Questions: ${model.questionsLength}'),
        Text('Current question: ${model.currentQuestion}'),

        // question progress bar

        // card goes here

        SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              child: const Icon(Icons.arrow_forward_rounded),
            )
          ],
        )
      ],
    ));
  }

  Widget endView(QuizModel model) {
    return myDefaultPadding(Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 100),
          decoration: const BoxDecoration(color: Colors.green),
          child: const Center(
            child: Text('Advert goes here!'),
          ),
        ),
        SizedBox(height: 50,),
        // enhance the text below, maybe add animation and change text and font
        const Text(
            'Congratulations! You have completed the quiz. To take the quiz again, click the \'reset quiz\' button below.'),
        SizedBox(height: 50,),
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              model.resetQuiz();
            },
            child: Text('Reset quiz'),
          ),
        )
      ],
    ));
  }

  Widget myDefaultPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: child,
    );
  }

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
