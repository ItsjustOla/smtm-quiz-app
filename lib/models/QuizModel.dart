
import 'package:flutter/cupertino.dart';
import 'package:smtm_app/helpers/questions_helper.dart';
import 'package:smtm_app/models/questions.dart';

import 'QuestionChoice.dart';

class QuizModel extends ChangeNotifier {

  List<QaPair> _questions = List.empty();
  int _currentQuestionIndex = 0;

  // QuestionFlipCard get questionCard => QuestionFlipCard(_questions[_currentQuestionIndex]);

  int get questionsLength => _questions.length;
  int get currentQuestionIndex => _currentQuestionIndex ;
  int get currentQuestionDisplay => _currentQuestionIndex + 1; // used for display purposes
  bool get isLastQuestion => currentQuestionDisplay == questionsLength; // used for display purposes - show quiz end page
  QaPair get currentQuestion => _questions[currentQuestionIndex];

  void nextQuestion(){
    if( questionsLength > 0 && currentQuestionDisplay == questionsLength + 1){
      return;
    }
    _currentQuestionIndex += 1;
    notifyListeners();
  }

  void previousQuestion(){
    if(_currentQuestionIndex <= 0){ // maybe set to -1?
      return;
    }
    _currentQuestionIndex -= 1;
    notifyListeners();
  }

  void resetQuiz(){
    _questions = List.empty();
    _currentQuestionIndex = 0;
    notifyListeners();
  }

  Future<void> getQuestions(QuestionChoice choice) async {
    final allQs = await QuestionsHelper().getQuestions();
    switch (choice) {
      case QuestionChoice.all:
        var qs = handleAllQuestions(allQs);
        _questions = qs;
        _questions.shuffle();
        notifyListeners();
        break;
      case QuestionChoice.tellMe:
        var tmQs = allQs.tmQuestions.qaPair;
        _questions = tmQs;
        _questions.shuffle();
        notifyListeners();
        break;
      case QuestionChoice.showMe:
        var smQs = allQs.smQuestions.qaPair;
        _questions = smQs;
        _questions.shuffle();
        notifyListeners();
        break;
    }
  }

  List<QaPair> handleAllQuestions(AllQuestions qs){
    final items = qs.smQuestions.qaPair;
    items.addAll(qs.tmQuestions.qaPair);
    return items;
  }

}
