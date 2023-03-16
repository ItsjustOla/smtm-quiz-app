import 'dart:convert';
import 'package:flutter/services.dart';

import '../dataModels/questions.dart';

class QuestionsHelper {
  Future<AllQuestions> getQuestions() async {
    Map<String, dynamic> data = await rootBundle.loadString('assets/questions.json').then((value) => jsonDecode(value));
    // await Future.delayed(const Duration(seconds: 4));
    return AllQuestions.fromJson(data);
  }
}