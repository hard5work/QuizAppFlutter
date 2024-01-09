import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/classes/result.dart';
import 'package:quiz_app_flutter/models/response_body.dart';
import 'dart:async';

import 'package:quiz_app_flutter/utils/api_handler.dart';

class QuizClass extends StatefulWidget {
  const QuizClass({super.key});

  @override
  State<QuizClass> createState() => _QuizClassState();
}

class _QuizClassState extends State<QuizClass> {
  int _current = 120;
  late Timer _timer;
  List<ResponseBody> quizList = [];
  ResponseBody? currentQuestion;
  int curQuestion = 1;
  var selectedAnswer = Colors.purple;
  var correctAnswer = Colors.green;
  var wrongAnswer = Colors.red;
  var unSelectedAnswer = Colors.blueGrey;
  var disableAnswer = Colors.grey;
  String? correctAnswerIs = '';
  List<String> multipleCorrectAnswers = [];
  bool isAnswerTabbed = false;
  bool isMultipleQs = false;
  String? myCorrectAnswer = '';

  int totalPoints = 0;

  String isMultipleQuestion = '';

  bool isAnswerASelected = false;
  bool isAnswerBSelected = false;
  bool isAnswerCSelected = false;
  bool isAnswerDSelected = false;
  bool isAnswerESelected = false;
  bool isAnswerFSelected = false;

  void _onAnswerTapped(int answer) {
    if (isMultipleQuestion != 'true') {
      if (!isAnswerTabbed) {
        setState(() {
          isAnswerTabbed = true;
          changeAnswerFunc(answer);
          unSelectedAnswer = disableAnswer;
          myCorrectAnswer = correctAnswerIs;
        });
      }
    } else {
      setState(() {
        isAnswerTabbed = true;
        multipleChooseAnswers(answer);
      });
    }
  }

  bool isAnsACorrect() {
    // if (isMultipleQs) {
    //   if (multipleCorrectAnswers.contains('answer_a')) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } else {
      if ('answer_a' == correctAnswerIs) {
        return true;
      } else {
        return false;
      }
    // }
  }

  bool isAnsBCorrect() {
    // if (isMultipleQs) {
    //   if (multipleCorrectAnswers.contains('answer_b')) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } else {
      if ('answer_b' == correctAnswerIs) {
        return true;
      } else {
        return false;
      }
    // }
  }

  bool isAnsCCorrect() {
    // if (isMultipleQs) {
    //   if (multipleCorrectAnswers.contains('answer_c')) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } else {
      if ('answer_c' == correctAnswerIs) {
        return true;
      } else {
        return false;
      }
    // }
  }

  bool isAnsDCorrect() {
    // if (isMultipleQs) {
    //   if (multipleCorrectAnswers.contains('answer_d')) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } else {
      if ('answer_d' == correctAnswerIs) {
        return true;
      } else {
        return false;
      }
    // }
  }

  bool isAnsECorrect() {
    // if (isMultipleQs) {
    //   if (multipleCorrectAnswers.contains('answer_e')) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } else {
      if ('answer_e' == correctAnswerIs) {
        return true;
      } else {
        return false;
      }
    // }
  }

  bool isAnsFCorrect() {
    // if (isMultipleQs) {
    //   if (multipleCorrectAnswers.contains('answer_f')) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } else {
      if ('answer_f' == correctAnswerIs) {
        return true;
      } else {
        return false;
      }
    // }
  }

  void changeAnswerFunc(int answer) {
    setAllAnswerFalse();
    switch (answer) {
      case 1:
        isAnswerASelected = !isAnswerASelected;
        break;
      case 2:
        isAnswerBSelected = !isAnswerBSelected;
        break;
      case 3:
        isAnswerCSelected = !isAnswerCSelected;
        break;
      case 4:
        isAnswerDSelected = !isAnswerDSelected;
        break;
      case 5:
        isAnswerESelected = !isAnswerESelected;
        break;
      case 6:
        isAnswerFSelected = !isAnswerFSelected;
        break;
      default:
        setAllAnswerFalse();
        break;
    }
  }

  void multipleChooseAnswers(int answer) {
    switch (answer) {
      case 1:
        isAnswerASelected = true;
        break;
      case 2:
        isAnswerBSelected = true;
        break;
      case 3:
        isAnswerCSelected = true;
        break;
      case 4:
        isAnswerDSelected = true;
        break;
      case 5:
        isAnswerESelected = true;
        break;
      case 6:
        isAnswerFSelected = true;
        break;
      default:
        setAllAnswerFalse();
        break;
    }
  }

  String setSelectedAnswer() {
    if (isAnswerASelected) {
      return 'answer_a';
    } else if (isAnswerBSelected) {
      return 'answer_b';
    } else if (isAnswerCSelected) {
      return 'answer_c';
    } else if (isAnswerDSelected) {
      return 'answer_d';
    } else if (isAnswerESelected) {
      return 'answer_e';
    } else if (isAnswerFSelected) {
      return 'answer_f';
    } else {
      return '';
    }
  }

  void checkAnswers() {
      if (isMultipleQuestion != 'true') {
        if (correctAnswerIs == setSelectedAnswer()) {
          setState(() {
            totalPoints += 10;
          });
        }
      } else {
        setState(() {
          totalPoints += 10;
        });
      }
    getNextQuestion();
  }

  void getNextQuestion() {
    if (setSelectedAnswer() != '') {
      if (curQuestion < 10) {
        setState(() {
          setAllAnswerFalse();
          isAnswerTabbed = false;
          currentQuestion = quizList[generateRandomNumber()];
          isMultipleQuestion = currentQuestion?.multipleCorrectAnswers ?? '';
          isMultipleQs = isMultipleQuestion == 'true';
          correctAnswerIs = correctAnswers(currentQuestion?.correctAnswers);
          curQuestion++;
          unSelectedAnswer = Colors.blueGrey;
          myCorrectAnswer = '';
        });
      } else {
        navigateToResult(context);
      }
    } else {
      simpleDialog();
    }
  }

  String correctAnswers(CorrectAnswers? answers) {
    if (answers == null) return '';
    if (isMultipleQuestion == 'true') {
      if (answers.answerACorrect == 'true') {
        multipleCorrectAnswers.add('answer_a');
      }
      if (answers.answerBCorrect == 'true') {
        multipleCorrectAnswers.add('answer_b');
      }
      if (answers.answerCCorrect == 'true') {
        multipleCorrectAnswers.add('answer_c');
      }
      if (answers.answerDCorrect == 'true') {
        multipleCorrectAnswers.add('answer_d');
      }
      if (answers.answerECorrect == 'true') {
        multipleCorrectAnswers.add('answer_e');
      }
      if (answers.answerFCorrect == 'true') {
        multipleCorrectAnswers.add('answer_f');
      }
    }
    if (answers.answerACorrect == 'true') {
      return 'answer_a';
    } else if (answers.answerBCorrect == 'true') {
      return 'answer_b';
    } else if (answers.answerCCorrect == 'true') {
      return 'answer_c';
    } else if (answers.answerDCorrect == 'true') {
      return 'answer_d';
    } else if (answers.answerECorrect == 'true') {
      return 'answer_e';
    } else if (answers.answerFCorrect == 'true') {
      return 'answer_f';
    } else {
      return '';
    }
  }

  Future<void> simpleDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Please! select atleast one answer.'),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 'Okay');
                },
                child: const Text('Okay'),
              ),
            ],
          );
        });
  }

  void setAllAnswerFalse() {
    isAnswerASelected = false;
    isAnswerBSelected = false;
    isAnswerCSelected = false;
    isAnswerDSelected = false;
    isAnswerESelected = false;
    isAnswerFSelected = false;
  }

  void startTimer(BuildContext context) {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_current == 0) {
          navigateToResult(context);
        } else {
          _current--;
        }
      });
    });
  }

  Color getCardColor(bool answer) {
    if (answer) {
      if (isAnswerTabbed) {
        if (correctAnswerIs == setSelectedAnswer()) {
          return Colors.green; // Change color for correct answer
        } else {
          return Colors.red; // Change color for wrong answer
        }
      } else {
        return Colors.grey; // Change color for unselected answer
      }
    } else {
      return unSelectedAnswer;
    }
  }

  Color checkColor() {
    if (isAnswerTabbed) {
      if (isAnswerASelected) {
        return correctAnswer;
      } else {
        return unSelectedAnswer;
      }
    } else {
      return unSelectedAnswer;
    }
  }

  void navigateToResult(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultClass(
            results: totalPoints,
          ),
        ));
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    startTimer(context);
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<ResponseBody> quizData = await fetchDataWithHeaders();
      // Use the retrieved data as needed
      setState(() {
        quizList = quizData;
        currentQuestion = quizList[generateRandomNumber()];
        isMultipleQuestion = currentQuestion?.multipleCorrectAnswers ?? '';
        isMultipleQs = isMultipleQuestion == 'true';
        correctAnswerIs = correctAnswers(currentQuestion?.correctAnswers);
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error scenario
    }
  }

  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(quizList.length - 1);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestion == null) {
      return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
          ),
          home: const Scaffold(
              backgroundColor: Colors.orange,
              body: Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('Please wait.'),
                  ),
                ),
              )));
    }

    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        ),
        home: Scaffold(
          backgroundColor: Colors.orange,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: _current.toDouble() / 120,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.orangeAccent),
                              ),
                              Text(
                                _current.toString(),
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                              child: Center(
                                  child: Text('Questions $curQuestion/10'))),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Wrap(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 215, 134, 27),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(totalPoints.toString()),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            currentQuestion!.question,
                            style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Visibility(
                            visible: (isMultipleQuestion == 'true'),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Choose multiple answers',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Visibility(
                            visible: true,
                            child: GestureDetector(
                              onTap: () {
                                _onAnswerTapped(1);
                              },
                              child: Card(
                                color: isAnswerTabbed
                                    ? (isAnsACorrect()
                                        ? correctAnswer
                                        : getCardColor(isAnswerASelected))
                                    : getCardColor(isAnswerASelected),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(currentQuestion!.answers.answerA,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: true,
                            child: GestureDetector(
                              onTap: () {
                                _onAnswerTapped(2);
                              },
                              child: Card(
                                color: isAnswerTabbed
                                    ? (isAnsBCorrect()
                                        ? correctAnswer
                                        : getCardColor(isAnswerBSelected))
                                    : getCardColor(isAnswerBSelected),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(currentQuestion!.answers.answerB,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: currentQuestion!.answers.answerC != null,
                            child: GestureDetector(
                              onTap: () {
                                _onAnswerTapped(3);
                              },
                              child: Card(
                                color: isAnswerTabbed
                                    ? (isAnsCCorrect()
                                        ? correctAnswer
                                        : getCardColor(isAnswerCSelected))
                                    : getCardColor(isAnswerCSelected),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                      currentQuestion!.answers.answerC ?? '',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: currentQuestion!.answers.answerD != null,
                            child: GestureDetector(
                              onTap: () {
                                _onAnswerTapped(4);
                              },
                              child: Card(
                                color: isAnswerTabbed
                                    ? (isAnsDCorrect()
                                        ? correctAnswer
                                        : getCardColor(isAnswerDSelected))
                                    : getCardColor(isAnswerDSelected),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                      currentQuestion!.answers.answerD ?? '',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: currentQuestion!.answers.answerE != null,
                            child: GestureDetector(
                              onTap: () {
                                _onAnswerTapped(5);
                              },
                              child: Card(
                                color: isAnswerTabbed
                                    ? (isAnsECorrect()
                                        ? correctAnswer
                                        : getCardColor(isAnswerESelected))
                                    : getCardColor(isAnswerESelected),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                      currentQuestion!.answers.answerE ?? '',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: currentQuestion!.answers.answerF != null,
                            child: GestureDetector(
                              onTap: () {
                                _onAnswerTapped(6);
                              },
                              child: Card(
                                color: isAnswerTabbed
                                    ? (isAnsFCorrect()
                                        ? correctAnswer
                                        : getCardColor(isAnswerFSelected))
                                    : getCardColor(isAnswerFSelected),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                      currentQuestion!.answers.answerF ?? '',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                    onPressed: () {
                      checkAnswers();
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(color: Colors.orange),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Icon(
                          Icons.arrow_right_alt_outlined,
                          color: Colors.orange,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
