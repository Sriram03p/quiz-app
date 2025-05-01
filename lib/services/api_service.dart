import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_ap/models/question.dart';

class ApiService {
  static const String _baseUrl = 'https://opentdb.com/api.php';

  Future<List<Question>> fetchQuestions() async {
    try {
      final response = await http.get(
          Uri.parse('$_baseUrl?amount=5&type=multiple')
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;

        return results.map((q) {
          // Combine correct and incorrect answers
          final options = List<String>.from(q['incorrect_answers'])
            ..add(q['correct_answer'])
            ..shuffle();

          return Question(
            questionText: q['question'],
            options: options,
            correctAnswerIndex: options.indexOf(q['correct_answer']),
          );
        }).toList();
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      throw Exception('Failed to fetch questions: $e');
    }
  }
}