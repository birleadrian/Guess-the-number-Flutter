import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const GuessNumber());
}

class GuessNumber extends StatelessWidget {
  const GuessNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess my number',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MyHomePage(title: 'Guess my number'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int number = Random().nextInt(100);
  int? inputNumber = 0;
  final TextEditingController numberTextFieldController = TextEditingController();
  String guessMessage = '';

  void guessNumber() {
    setState(() {
      if (numberTextFieldController.text.isEmpty) {
        guessMessage = '';
        return;
      }
      inputNumber = int.tryParse(numberTextFieldController.text);
      if (inputNumber == null) {
        guessMessage = '';
        return;
      }
      // print(number); // for test purpose
      if (inputNumber == number) {
        guessMessage = "You tried $inputNumber\nYou've guessed the number.";
      } else if (inputNumber! < number) {
        guessMessage = 'You tried $inputNumber\nTry higher.';
      } else {
        guessMessage = 'You tried $inputNumber\nTry lower.';
      }
    });
  }

  @override
  void dispose() {
    numberTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "I'm thinking of a number between 1 and 100.",
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "It's your turn to guess my number!",
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  guessMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Card(
                  child: SizedBox(
                    width: 400,
                    height: 200,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          const Text('Try a number!'),
                          TextField(
                            controller: numberTextFieldController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              onPressed: guessNumber,
                              child: const Text('Guess'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
