import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_ap/providers/quiz_provider.dart';

void main() {
  group('QuizProvider', () {
    late QuizProvider quizProvider;

    setUp(() {
      quizProvider = QuizProvider();
    });

    test('initial values are correct', () {
      expect(quizProvider.currentQuestionIndex, 0);
      expect(quizProvider.score, 0);
      expect(quizProvider.isAnswered, false);
      expect(quizProvider.selectedOptionIndex, null);
      expect(quizProvider.questions.length, 5);
    });

    test('checkAnswer updates state correctly for correct answer', () {
      final question = quizProvider.questions[0];
      quizProvider.checkAnswer(question.correctAnswerIndex);

      expect(quizProvider.isAnswered, true);
      expect(quizProvider.selectedOptionIndex, question.correctAnswerIndex);
      expect(quizProvider.score, 10);
    });

    test('checkAnswer updates state correctly for incorrect answer', () {
      final question = quizProvider.questions[0];
      final wrongAnswerIndex = (question.correctAnswerIndex + 1) % question.options.length;
      quizProvider.checkAnswer(wrongAnswerIndex);

      expect(quizProvider.isAnswered, true);
      expect(quizProvider.selectedOptionIndex, wrongAnswerIndex);
      expect(quizProvider.score, 0);
    });

    test('nextQuestion updates currentQuestionIndex', () {
      quizProvider.nextQuestion();
      expect(quizProvider.currentQuestionIndex, 1);
      expect(quizProvider.isAnswered, false);
      expect(quizProvider.selectedOptionIndex, null);
    });

    test('resetQuiz resets all values', () {
      // First answer a question and move to next
      quizProvider.checkAnswer(0);
      quizProvider.nextQuestion();

      // Then reset
      quizProvider.resetQuiz();

      expect(quizProvider.currentQuestionIndex, 0);
      expect(quizProvider.score, 0);
      expect(quizProvider.isAnswered, false);
      expect(quizProvider.selectedOptionIndex, null);
    });
  });
}