import 'package:flutter/material.dart';
import 'package:quiz_app_enhancement/data/questions.dart';
import 'package:quiz_app_enhancement/questions_container.dart';
import 'package:quiz_app_enhancement/results_container.dart';
import 'package:quiz_app_enhancement/start_container.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeContainer = 'start-container';

  void switchContainer() {
    setState(() {
      activeContainer = 'questions-container';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeContainer = 'results-container';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeContainer = 'questions-container';
    });
  }

  @override
  Widget build(context) {
    Widget containerWidget = StartContainer(switchContainer);

    if (activeContainer == 'questions-container') {
      containerWidget = QuestionsContainer(onSelectedAnswer: chooseAnswer);
    }
    if (activeContainer == 'results-container') {
      containerWidget = ResultsContainer(selectedAnswers, onRestart: restartQuiz);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: containerWidget,
        ),
      ),
    );
  }
}
