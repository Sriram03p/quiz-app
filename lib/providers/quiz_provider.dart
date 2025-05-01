import 'package:flutter/material.dart';
import 'package:quiz_ap/models/question.dart';
import 'package:quiz_ap/services/api_service.dart';

class QuizProvider with ChangeNotifier {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  int? _selectedOptionIndex;
  bool _isLoading = false;
  String? _error;
  bool _useLocalQuestions = true;

  final ApiService _apiService = ApiService();

  // Local questions
  final List<Question> _localQuestions = [
    Question(
      questionText: "What is the capital of France?",
      options: ["London", "Berlin", "Paris", "Madrid"],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: "Which planet is known as the Red Planet?",
      options: ["Venus", "Mars", "Jupiter", "Saturn"],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "Who painted the Mona Lisa?",
      options: [
        "Vincent van Gogh",
        "Pablo Picasso",
        "Leonardo da Vinci",
        "Michelangelo"
      ],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: "What is the largest mammal?",
      options: ["Elephant", "Blue Whale", "Giraffe", "Polar Bear"],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "Which language is Flutter based on?",
      options: ["Java", "Kotlin", "Dart", "Swift"],
      correctAnswerIndex: 2,
    ),
  ];

  QuizProvider() {
    // Initialize with local questions
    _questions = List.from(_localQuestions);
  }

  List<Question> get questions => _questions;
  List<Question> get localQuestions => _localQuestions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get isAnswered => _isAnswered;
  int? get selectedOptionIndex => _selectedOptionIndex;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get useLocalQuestions => _useLocalQuestions;

  Future<void> loadQuestions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (_useLocalQuestions) {
        _questions = List.from(_localQuestions);
      } else {
        _questions = await _apiService.fetchQuestions();
      }
      _resetQuizState();
    } catch (e) {
      _error = e.toString();
      // Fallback to local questions if API fails
      if (!_useLocalQuestions) {
        _questions = List.from(_localQuestions);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addQuestion(Question question) {
    _localQuestions.add(question);
    if (_useLocalQuestions) {
      _questions = List.from(_localQuestions);
    }
    notifyListeners();
  }

  void updateQuestion(int index, Question question) {
    _localQuestions[index] = question;
    if (_useLocalQuestions) {
      _questions = List.from(_localQuestions);
      // Reset quiz if we're updating a question in the current quiz
      if (index < _questions.length) {
        _resetQuizState();
      }
    }
    notifyListeners();
  }

  void deleteQuestion(int index) {
    _localQuestions.removeAt(index);
    if (_useLocalQuestions) {
      _questions = List.from(_localQuestions);
      // Reset quiz if we're deleting a question in the current quiz
      if (index < _questions.length) {
        _resetQuizState();
      }
    }
    notifyListeners();
  }

  void _resetQuizState() {
    _currentQuestionIndex = 0;
    _score = 0;
    _isAnswered = false;
    _selectedOptionIndex = null;
  }

  void toggleQuestionSource(bool useLocal) {
    if (_useLocalQuestions == useLocal) return;

    _useLocalQuestions = useLocal;
    loadQuestions();
  }

  void checkAnswer(int selectedOptionIndex) {
    _isAnswered = true;
    _selectedOptionIndex = selectedOptionIndex;

    if (selectedOptionIndex == _questions[_currentQuestionIndex].correctAnswerIndex) {
      _score += 10;
    }

    notifyListeners();
  }

  void nextQuestion() {
    _currentQuestionIndex++;
    _isAnswered = false;
    _selectedOptionIndex = null;
    notifyListeners();
  }

  void resetQuiz() {
    _resetQuizState();
    notifyListeners();
  }
}