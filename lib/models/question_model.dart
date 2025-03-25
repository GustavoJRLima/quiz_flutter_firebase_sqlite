class QuestionModel {
  int id;
  String question;
  String answer;
  List options;

  QuestionModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.options,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': options.join(';'),
      'answer': answer,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'],
      question: map['question'],
      options: map['options'].split(';'),
      answer: map['answer'],
    );
  }
}
