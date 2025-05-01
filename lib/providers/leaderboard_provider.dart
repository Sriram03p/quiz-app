import 'package:flutter/material.dart';
import 'package:quiz_ap/models/user_score.dart';
import 'package:quiz_ap/services/database_helper.dart';

class LeaderboardProvider with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<UserScore> _scores = [];

  List<UserScore> get scores => _scores;

  Future<void> loadScores() async {
    _scores = await _databaseHelper.getScores();
    _scores.sort((a, b) => b.score.compareTo(a.score));
    notifyListeners();
  }

  Future<void> addScore(UserScore score) async {
    await _databaseHelper.insertScore(score);
    await loadScores();
  }

  Future<void> clearScores() async {
    await _databaseHelper.clearScores();
    await loadScores();
  }
}