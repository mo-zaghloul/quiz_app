import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/cubit/quiz/quiz_state.dart';
import 'package:quiz_app/models/quiz_result.dart';
import 'package:quiz_app/repositories/quiz_repository.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepository _quizRepository;

  QuizCubit({required QuizRepository quizRepository}) 
      : _quizRepository = quizRepository,
        super(const QuizState());

  Future<void> loadQuestions() async {
    try {
      emit(state.copyWith(status: QuizStatus.loading));
      
      final questions = await _quizRepository.getQuestions();
      
      emit(state.copyWith(
        questions: questions,
        status: QuizStatus.active,
        currentQuestionIndex: 0,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: QuizStatus.error,
        error: 'Failed to load questions: $e',
      ));
    }
  }

  void answerQuestion(String optionId, int timeSpent) {
    if (state.status != QuizStatus.active || state.currentQuestion == null) {
      return;
    }

    final currentQuestion = state.currentQuestion!;
    final isCorrect = optionId == currentQuestion.correctOptionId;

    final userAnswer = UserAnswer(
      questionId: currentQuestion.id,
      selectedOptionId: optionId,
      isCorrect: isCorrect,
      timeSpent: timeSpent,
    );

    final updatedUserAnswers = Map<String, UserAnswer>.from(state.userAnswers);
    updatedUserAnswers[currentQuestion.id] = userAnswer;

    final updatedTotalTime = state.totalTime + timeSpent;

    emit(state.copyWith(
      userAnswers: updatedUserAnswers,
      totalTime: updatedTotalTime,
    ));

    if (state.isLastQuestion) {
      _completeQuiz();
    } else {
      _goToNextQuestion();
    }
  }

  void skipQuestion(int timeSpent) {
    if (state.status != QuizStatus.active || state.currentQuestion == null) {
      return;
    }

    final currentQuestion = state.currentQuestion!;
    
    final userAnswer = UserAnswer(
      questionId: currentQuestion.id,
      selectedOptionId: null,
      isCorrect: false,
      timeSpent: timeSpent,
    );

    final updatedUserAnswers = Map<String, UserAnswer>.from(state.userAnswers);
    updatedUserAnswers[currentQuestion.id] = userAnswer;

    final updatedTotalTime = state.totalTime + timeSpent;

    emit(state.copyWith(
      userAnswers: updatedUserAnswers,
      totalTime: updatedTotalTime,
    ));

    if (state.isLastQuestion) {
      _completeQuiz();
    } else {
      _goToNextQuestion();
    }
  }

  void timeExpired() {
    skipQuestion(state.currentQuestion?.timeLimit ?? 30);
  }

  void _goToNextQuestion() {
    emit(state.copyWith(
      currentQuestionIndex: state.currentQuestionIndex + 1,
    ));
  }

  void _completeQuiz() {
    final result = QuizResult(
      userAnswers: state.userAnswers,
      totalQuestions: state.questions.length,
      totalTime: state.totalTime,
    );

    emit(state.copyWith(
      status: QuizStatus.completed,
      result: result,
    ));
  }

  void restartQuiz() {
    emit(const QuizState());
    loadQuestions();
  }
}