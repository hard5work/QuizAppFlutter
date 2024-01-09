class ResponseBody {
  final int id;
  final String question;
  final String? description;
  final Answers answers;
  final String multipleCorrectAnswers;
  final CorrectAnswers correctAnswers;
  final String? correctAnswer;
  final String? explanation;
  final String? tip;
  final List<Tag> tags;
  final String category;
  final String difficulty;

  ResponseBody({
    required this.id,
    required this.question,
    this.description,
    required this.answers,
    required this.multipleCorrectAnswers,
    required this.correctAnswers,
    this.correctAnswer,
    this.explanation,
    this.tip,
    required this.tags,
    required this.category,
    required this.difficulty,
  });

  factory ResponseBody.fromJson(Map<String, dynamic> json) {
    return ResponseBody(
      id: json['id'],
      question: json['question'],
      description: json['description'],
      answers: Answers.fromJson(json['answers']),
      multipleCorrectAnswers: json['multiple_correct_answers'],
      correctAnswers: CorrectAnswers.fromJson(json['correct_answers']),
      correctAnswer: json['correct_answer'],
      explanation: json['explanation'],
      tip: json['tip'],
      tags: List<Tag>.from(json['tags'].map((tag) => Tag.fromJson(tag))),
      category: json['category'],
      difficulty: json['difficulty'],
    );
  }
}

class Answers {
  final String answerA;
  final String answerB;
  final String? answerC;
  final String? answerD;
  final String? answerE;
  final String? answerF;

  Answers({
    required this.answerA,
    required this.answerB,
    this.answerC,
    this.answerD,
    this.answerE,
    this.answerF,
  });

  factory Answers.fromJson(Map<String, dynamic> json) {
    return Answers(
      answerA: json['answer_a'],
      answerB: json['answer_b'],
      answerC: json['answer_c'],
      answerD: json['answer_d'],
      answerE: json['answer_e'],
      answerF: json['answer_f'],
    );
  }
}

class CorrectAnswers {
  final String answerACorrect;
  final String answerBCorrect;
  final String answerCCorrect;
  final String answerDCorrect;
  final String answerECorrect;
  final String answerFCorrect;

  CorrectAnswers({
    required this.answerACorrect,
    required this.answerBCorrect,
    required this.answerCCorrect,
    required this.answerDCorrect,
    required this.answerECorrect,
    required this.answerFCorrect,
  });

  factory CorrectAnswers.fromJson(Map<String, dynamic> json) {
    return CorrectAnswers(
      answerACorrect: json['answer_a_correct'],
      answerBCorrect: json['answer_b_correct'],
      answerCCorrect: json['answer_c_correct'],
      answerDCorrect: json['answer_d_correct'],
      answerECorrect: json['answer_e_correct'],
      answerFCorrect: json['answer_f_correct'],
    );
  }
}

class Tag {
  final String name;

  Tag({
    required this.name,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
    );
  }
}
