import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/classes/quizes.dart';
import 'package:quiz_app_flutter/helper/shared_pref_helper.dart';

class ResultClass extends StatefulWidget {
  const ResultClass({super.key});

  @override
  State<ResultClass> createState() => _ResultClassState();
}

class _ResultClassState extends State<ResultClass> {
  String? storedValue = '';
  Future<void> _checkStoredValue() async {
    String? values = await SharedPreferencesHelper.getValue('name');
    setState(() {
      storedValue = values ?? '';
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkStoredValue();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: Scaffold(
        backgroundColor: Colors.orange,
        body: Center(
          child: Column(
            children: [
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/5987/5987898.png',
                width: 200.0,
                height: 200.0,
              ),
              Text('Excellent \'$storedValue\''),
              const Wrap(
                clipBehavior: Clip.none,
                children: [
                  Card(
                    margin: EdgeInsets.all(40.0),
                    color: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Score',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  child: Center(
                                    child: SizedBox(
                                      width: 200.0,
                                      height: 200.0,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 20.0,
                                        value: 1,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        '20',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Your Score was 20 points.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox(height: 10.0,)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuizClass()));
                    },
                    child: const Text('Take Another Shot')),
              ),
              const SizedBox(height: 20.0,)
            ],
          ),
        ),
      ),
    );
  }
}
