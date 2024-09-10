import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app_enhancement/answer_button.dart';
import 'package:quiz_app_enhancement/data/questions.dart';
import 'package:quiz_app_enhancement/strikes_container.dart';

class QuestionsContainer extends StatefulWidget {
  const QuestionsContainer({
    super.key,
    required this.onSelectedAnswer,
  });

  final void Function(String answer) onSelectedAnswer;

  @override
  State<QuestionsContainer> createState() {
    return _QuestionsContainerState();
  }
}

class _QuestionsContainerState extends State<QuestionsContainer> {
  var currentQuestionIndex = 0;
  var strikeCount = 0;

  void answerQuestion(String selectedAnswer, String correctAnswer) {
    widget.onSelectedAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
      if (selectedAnswer != correctAnswer) {
        strikeCount++;
      }
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40.0),
        /* Code gathered from
           https://stackoverflow.com/questions/49566752/flutter-position-fixed-equivalent at
           2024.09.09 */
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  currentQuestion.text,
                  style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 201, 153, 251),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                ...currentQuestion.getShuffeldAnswers().map((answer) {
                  return AnswerButton(
                    answerText: answer,
                    onClick: () {
                      answerQuestion(answer, currentQuestion.getCorrectAnswer());
                    },
                  );
                }),
              ],
            ),
            StrikesContainer(strikeCount),
          ],
        ),
      ),
    );
  }
}
