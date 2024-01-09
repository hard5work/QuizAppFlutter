import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/classes/quizes.dart';
import 'package:quiz_app_flutter/helper/shared_pref_helper.dart';

class IntroClass extends StatefulWidget {
  const IntroClass({super.key});

  @override
  State<IntroClass> createState() => _IntroClassState();
}

class _IntroClassState extends State<IntroClass> {
  String? storedValue = '';

  String _inputValue = '';
  TextEditingController _textEditingController = TextEditingController();

  Future<void> _checkStoredValue() async {
    String? values = await SharedPreferencesHelper.getValue('name');
    setState(() {
      storedValue = values ?? '';
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkStoredValue();
    
  }

  @override
  Widget build(BuildContext context) {
    if (storedValue!.isNotEmpty) {
          return const MaterialApp(
            home: Scaffold(
              body: QuizClass()
             ),
          );
    }

    void _getInputValue() {
      setState(() {
        _inputValue = _textEditingController.text;
      });
      print('Input Value: $_inputValue');
      SharedPreferencesHelper.saveValue('name', _inputValue);
    }

    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: Scaffold(
          backgroundColor: Colors.orange,
          body: Center(
            child: Wrap(children: [
              Card(
                margin: const EdgeInsets.all(20.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'WELCOME TO QUIZ APP',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20.0),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'What should we call you?',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                            fontSize: 14.0),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _textEditingController,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      // ignore: avoid_print
                      ElevatedButton(
                          onPressed: () {
                            _getInputValue();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const QuizClass()));
                          },
                          child: const Text('Create User'))
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
