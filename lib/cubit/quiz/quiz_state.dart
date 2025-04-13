import 'package:equatable/equatable.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/quiz_result.dart';

enum QuizStatus { initial, loading, active, completed, error }

class QuizState extends Equatable {
  final List<Question> questions;
  final int currentQuestionIndex;
  final QuizStatus status;
  final String? error;
  final QuizResult? result;
  final Map<String, UserAnswer> userAnswers;
  final int totalTime; // in seconds

  const QuizState({
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.status = QuizStatus.initial,
    this.error,
    this.result,
    this.userAnswers = const {},
    this.totalTime = 0,
  });

  bool get isLastQuestion => currentQuestionIndex >= questions.length - 1;
  
  Question? get currentQuestion => questions.isNotEmpty && currentQuestionIndex < questions.length
      ? questions[currentQuestionIndex]
      : null;

  QuizState copyWith({
    List<Question>? questions,
    int? currentQuestionIndex,
    QuizStatus? status,
    String? error,
    QuizResult? result,
    Map<String, UserAnswer>? userAnswers,
    int? totalTime,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      status: status ?? this.status,
      error: error,
      result: result ?? this.result,
      userAnswers: userAnswers ?? this.userAnswers,
      totalTime: totalTime ?? this.totalTime,
    );
  }

  @override
  List<Object?> get props => [
        questions,
        currentQuestionIndex,
        status,
        error,
        result,
        userAnswers,
        totalTime,
      ];
}