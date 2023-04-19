
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
  int get currentQuestion => _currentQuestionIndex + 1; // used for display purposes
  bool get isLastQuestion => currentQuestion == questionsLength; // used for display purposes

  void nextQuestion(){
    if( questionsLength > 0 && currentQuestion == questionsLength + 1){ // maybe set to -1?
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
        qs.shuffle;
        _questions = qs;
        break;
      case QuestionChoice.showMe:
        var smQs = allQs.smQuestions.qaPair;
        smQs.shuffle;
        _questions = smQs;
        break;
      case QuestionChoice.tellMe:
        var tmQs = allQs.tmQuestions.qaPair;
        tmQs.shuffle;
        _questions = tmQs;
        break;
    }
    notifyListeners();
  }

  List<QaPair> handleAllQuestions(AllQuestions qs){
    final items = qs.smQuestions.qaPair;
    items.addAll(qs.tmQuestions.qaPair);
    return items;
  }

}