import 'package:equatable/equatable.dart';

class QuizResult extends Equatable {
  final Map<String, UserAnswer> userAnswers;
  final int totalQuestions;
  final int totalTime; // in seconds

  const QuizResult({
    required this.userAnswers,
    required this.totalQuestions,
    required this.totalTime,
  });

  int get correctAnswers => userAnswers.values.where((answer) => answer.isCorrect).length;
  
  int get incorrectAnswers => userAnswers.values.where((answer) => 
      answer.selectedOptionId != null && !answer.isCorrect).length;
  
  int get unansweredQuestions => totalQuestions - userAnswers.length;
  
  double get scorePercentage => totalQuestions > 0 
      ? (correctAnswers / totalQuestions) * 100 
      : 0;
  
  String get formattedTime {
    final minutes = (totalTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalTime % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    final userAnswersMap = Map<String, UserAnswer>.from(
      (json['userAnswers'] as Map).map(
        (key, value) => MapEntry(
          key.toString(),
          UserAnswer.fromJson(value),
        ),
      ),
    );

    return QuizResult(
      userAnswers: userAnswersMap,
      totalQuestions: json['totalQuestions'],
      totalTime: json['totalTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userAnswers': userAnswers.map((key, value) => MapEntry(key, value.toJson())),
      'totalQuestions': totalQuestions,
      'totalTime': totalTime,
    };
  }

  @override
  List<Object?> get props => [userAnswers, totalQuestions, totalTime];
}

class UserAnswer extends Equatable {
  final String questionId;
  final String? selectedOptionId;
  final bool isCorrect;
  final int timeSpent; // in seconds

  const UserAnswer({
    required this.questionId,
    this.selectedOptionId,
    required this.isCorrect,
    required this.timeSpent,
  });

  factory UserAnswer.fromJson(Map<String, dynamic> json) {
    return UserAnswer(
      questionId: json['questionId'],
      selectedOptionId: json['selectedOptionId'],
      isCorrect: json['isCorrect'],
      timeSpent: json['timeSpent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'selectedOptionId': selectedOptionId,
      'isCorrect': isCorrect,
      'timeSpent': timeSpent,
    };
  }

  @override
  List<Object?> get props => [questionId, selectedOptionId, isCorrect, timeSpent];
}