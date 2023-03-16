
class QaPair{

  final String question;
  final String answer;

  QaPair(this.question, this.answer);

  QaPair.fromJson(Map<String, dynamic> json)
      : question = json['question'],
        answer = json['answer'];

}

class ShowMeQuestions{
  List<QaPair> qaPair;

  ShowMeQuestions(this.qaPair);

  ShowMeQuestions.fromJson(Map<String, dynamic> json)
    : qaPair = List<dynamic>.from(json['showMeQuestions'])
      .map((i) => QaPair.fromJson(i))
      .toList();
}

class TellMeQuestions{
  List<QaPair> qaPair;

  TellMeQuestions(this.qaPair);

  TellMeQuestions.fromJson(Map<String, dynamic> json)
      : qaPair = List<dynamic>.from(json['tellMeQuestions'])
      .map((i) => QaPair.fromJson(i))
      .toList();
}

class AllQuestions{
  final ShowMeQuestions smQuestions;
  final TellMeQuestions tmQuestions;

  AllQuestions(this.smQuestions, this.tmQuestions);

  AllQuestions.fromJson(Map<String, dynamic> json)
    : smQuestions = ShowMeQuestions.fromJson(json),
      tmQuestions = TellMeQuestions.fromJson(json);
}
