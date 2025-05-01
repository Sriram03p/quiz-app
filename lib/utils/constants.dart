class AppConstants {
  // API Constants
  static const apiBaseUrl = 'https://opentdb.com/api.php';
  static const defaultQuestionCount = 5;

  // Database Constants
  static const dbName = 'quiz_app.db';
  static const scoresTable = 'leaderboard';

  // Local Questions (Fallback)
  static const localQuestions = [
    {
      "questionText": "What is the capital of France?",
      "options": ["London", "Berlin", "Paris", "Madrid"],
      "correctAnswerIndex": 2
    },
    {
      "questionText": "Which planet is known as the Red Planet?",
      "options": ["Venus", "Mars", "Jupiter", "Saturn"],
      "correctAnswerIndex": 1
    }
  ];

  // UI Constants
  static const defaultAnimationDuration = Duration(milliseconds: 300);
  static const maxQuestionOptions = 4;
}