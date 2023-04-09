
import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/questions.dart';

class QuestionsHelper {
  Future<AllQuestions> getQuestions() async {
    Map<String, dynamic> data = await rootBundle.loadString('assets/questions.json').then((value) => jsonDecode(value));
    return AllQuestions.fromJson(data);
  }


}