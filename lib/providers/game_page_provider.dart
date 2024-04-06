import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  BuildContext context;

  final int _numberQuestions = 10;
  String difficulty;

  List? questions;
  var _currentQuestionIndex = 0;
  int _correctAnswers = 0;

  GamePageProvider({required this.context, required this.difficulty}) {
    dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestionsFromApi();
  }

  Future<void> _getQuestionsFromApi() async {
    var response = await dio.get(
      '',
      queryParameters: {
        'amount': _numberQuestions,
        'type': 'boolean',
        'difficulty': difficulty,
      },
    );
    var data = jsonDecode(response.toString());
    questions = data['results'];
    notifyListeners();
  }

  String getCurrentQuestion() {
    return questions![_currentQuestionIndex]['question'];
  }

  void answerQuestion(String answer) async {
    final bool isCorrect = questions![_currentQuestionIndex]['correct_answer'] == answer;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
        );
      }
    );
    if(isCorrect) {
      _correctAnswers++;
    }
    // Wait a second and hide the alert dialog
    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.pop(context);
    _currentQuestionIndex++;
    // If the current question is the last one, finish the game
    if(_currentQuestionIndex == _numberQuestions) {
      _endGame();
    }
    // Otherwise, notify the listener that the current question has changed
    else {
      notifyListeners();
    }
  }

  Future<void> _endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            "Game Finished",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Correct Answers: $_correctAnswers/$_numberQuestions",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.normal,
            ),
          ),
        );
      }
    );
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }
}