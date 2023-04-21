import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'models/QuizModel.dart';
import 'widgets/MyAppBar.dart';
import 'widgets/MyBottomNav.dart';
import 'helpers/color_constants.dart';
import '/helpers/text_constants.dart';
import 'models/QuestionChoice.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TextConstants {
  QuestionChoice _questionSelection = QuestionChoice.all;
  final FlipCardController _controller = FlipCardController();

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

  Widget getMyFlipCard(String question, String answer){
    return Expanded(
      child: Card(
        elevation: 0.0,
        color: Colors.transparent,
        child: FlipCard(
          controller: _controller,
          direction: FlipDirection.HORIZONTAL,
          side: CardSide.FRONT,
          speed: 750,
          front: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorConstants().myColor[400],
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Container(
              color: Colors.white70,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 14,),
                  Text('Question',
                      style: Theme.of(context).textTheme.titleLarge),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(question,
                      style: const TextStyle(
                        fontSize: 24.0, // or any other size that works for your design
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 0.5, // adjust this to add spacing between letters
                        height: 1.5, // adjust this to add spacing between lines
                      ),
                    ),
                  ),
                  const Spacer(flex: 2,),
                  Align(
                    child: Text('Tap card to reveal answer',
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  const SizedBox(height: 14,),
                ],
              ),
            ),
          ),
          back: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorConstants().myColor2[400],
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Container(
              color: Colors.white70,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 14,),
                  Text('Answer',
                      style: Theme.of(context).textTheme.titleLarge),
                  const Spacer(),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(answer,
                        style: const TextStyle(
                          fontSize: 18.0, // or any other size that works for your design
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 0.5, // adjust this to add spacing between letters
                          height: 1.5, // adjust this to add spacing between lines
                        ),
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  const Spacer(flex: 2,),
                  Align(
                    child: Text('Tap card to return to question',
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  const SizedBox(height: 14,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget quizView(QuizModel model) {
    return myDefaultPadding(Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
            alignment: Alignment.center,
            child: Text('Question: ${model.currentQuestionDisplay}/${model.questionsLength}',
            style: Theme.of(context).textTheme.titleMedium,),
        ),
        const SizedBox(height: 12,),
        StepProgressIndicator(
          totalSteps: model.questionsLength,
          currentStep: model.currentQuestionDisplay,
          size: 10,
          roundedEdges: const Radius.circular(10),
        ),
        const SizedBox(height: 22,),
        getMyFlipCard(model.currentQuestion.question, model.currentQuestion.answer),
        const SizedBox(height: 28,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                model.previousQuestion();
                if(!_controller.state!.isFront) _controller.toggleCard();
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
                if(!_controller.state!.isFront) _controller.toggleCard();
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
      body: Consumer<QuizModel>(
        builder: (context, quiz, child) {
          if (quiz.questionsLength <= 0) {
            return startView(quiz);
          } else if (quiz.currentQuestionIndex == quiz.questionsLength) {
            return endView(quiz);
          } else {
            return quizView(quiz);
          }
        },
      ),
      bottomNavigationBar: const MyBottomNav(
        currentIndex: 1,
      ),
    );
  }
}
