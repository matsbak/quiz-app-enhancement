import 'package:flutter/material.dart';
import 'package:quiz_app_enhancement/data/questions.dart';
import 'package:quiz_app_enhancement/questions_container.dart';
import 'package:quiz_app_enhancement/results_container.dart';
import 'package:quiz_app_enhancement/retry_container.dart';
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
  var strikeCount = 0;
  // Total allowed strikes in the quiz
  var totalAllowedStrikes = 3;
  var activeContainer = 'start-container';

  void switchContainer() {
    setState(() {
      activeContainer = 'questions-container';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (answer != questions[selectedAnswers.length - 1].answers[0]) {
      // If user selects an incorrect answer the strike count is incremented
      setState(() {
        strikeCount++;
      });
      if (strikeCount == totalAllowedStrikes) {
        // If user has reached total allowed strikes the user is sent to the retry screen
        setState(() {
          activeContainer = 'retry-container';
        });
      }
    } else if (selectedAnswers.length == questions.length) {
      setState(() {
        activeContainer = 'results-container';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      strikeCount = 0;
      activeContainer = 'questions-container';
    });
  }

  @override
  Widget build(context) {
    Widget containerWidget = StartContainer(switchContainer);

    if (activeContainer == 'questions-container') {
      containerWidget = QuestionsContainer(
        strikes: strikeCount,
        totalStrikes: totalAllowedStrikes,
        onSelectedAnswer: chooseAnswer,
      );
    }
    if (activeContainer == 'retry-container') {
      containerWidget = RetryContainer(onRetry: restartQuiz);
    }
    if (activeContainer == 'results-container') {
      containerWidget = ResultsContainer(
        selectedAnswers,
        onRestart: restartQuiz,
      );
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
