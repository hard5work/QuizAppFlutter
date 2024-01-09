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

  bool isAnswerASelected = false;
  bool isAnswerBSelected = false;
  bool isAnswerCSelected = false;
  bool isAnswerDSelected = false;
  bool isAnswerESelected = false;
  bool isAnswerFSelected = false;

  void _onAnswerTapped(int answer) {
    setState(() {
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

  void navigateToResult(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ResultClass()));
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
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error scenario
    }
  }

  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(
        quizList.length - 1); // Generates a random integer between 0 and 99
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
                          const Wrap(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 215, 134, 27),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text('10'),
                                  SizedBox(
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
                      child: Text(
                        currentQuestion!.question,
                        style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
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
                                color: isAnswerASelected
                                    ? Colors.green
                                    : Colors.blueAccent,
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
                                color: isAnswerBSelected
                                    ? Colors.green
                                    : Colors.blueAccent,
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
                                color: isAnswerCSelected
                                    ? Colors.green
                                    : Colors.blueAccent,
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
                                color: isAnswerDSelected
                                    ? Colors.green
                                    : Colors.blueAccent,
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
                                color: isAnswerESelected
                                    ? Colors.green
                                    : Colors.blueAccent,
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
                                color: isAnswerFSelected
                                    ? Colors.green
                                    : Colors.blueAccent,
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
                        backgroundColor: Colors.red,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                    onPressed: () {
                      if (curQuestion < 10) {
                        currentQuestion = quizList[generateRandomNumber()];
                        setState(() {
                          curQuestion++;
                        });
                      } else {
                        navigateToResult(context);
                      }
                    },
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
