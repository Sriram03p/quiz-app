class UserScore {
  final String userName;
  final int score;
  final DateTime dateTime;

  UserScore({
    required this.userName,
    required this.score,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'score': score,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory UserScore.fromMap(Map<String, dynamic> map) {
    return UserScore(
      userName: map['userName'],
      score: map['score'],
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}