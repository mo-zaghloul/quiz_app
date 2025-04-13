import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/cubit/quiz/quiz_cubit.dart';
import 'package:quiz_app/cubit/quiz/quiz_state.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/quiz_result.dart';
import 'package:quiz_app/screens/welcome_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/utils/constants.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        _navigateToWelcomeScreen(context);        
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Results'),
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            if (state.status != QuizStatus.completed) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final result = state.result;
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildScoreCard(context, result),
                      const SizedBox(height: 32),
                      _buildStatisticsCard(context, result),
                      const SizedBox(height: 32),
                      _buildQuestionSummary(context, result, state),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _tryAgain(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                'Try Again',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _navigateToWelcomeScreen(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black87,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                'Home',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildScoreCard(BuildContext context, QuizResult? result) {
    if (result == null) return const SizedBox.shrink();
    
    final scoreText = '${result.scorePercentage.toStringAsFixed(0)}%';
    final scoreColor = _getScoreColor(result.scorePercentage);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Your Score',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            scoreText,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: scoreColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            _getScoreMessage(result.scorePercentage),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[700],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsCard(BuildContext context, QuizResult? result) {
    if (result == null) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistics',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildStatisticsRow(
            context,
            icon: Icons.check_circle,
            iconColor: Colors.green,
            label: 'Correct',
            value: '${result.correctAnswers}',
          ),
          const Divider(),
          _buildStatisticsRow(
            context,
            icon: Icons.cancel,
            iconColor: Colors.red,
            label: 'Incorrect',
            value: '${result.incorrectAnswers}',
          ),
          const Divider(),
          _buildStatisticsRow(
            context,
            icon: Icons.help,
            iconColor: Colors.orange,
            label: 'Skipped',
            value: '${result.unansweredQuestions}',
          ),
          const Divider(),
          _buildStatisticsRow(
            context,
            icon: Icons.timer,
            iconColor: kPrimaryColor,
            label: 'Total Time',
            value: result.formattedTime,
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionSummary(BuildContext context, QuizResult? result, QuizState state) {
    if (result == null) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Questions Summary',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.questions.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final question = state.questions[index];
              final userAnswer = result.userAnswers[question.id];
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _getAnswerStatusColor(userAnswer),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question.text,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          if (userAnswer?.selectedOptionId != null) ...[
                            Text(
                              'Your answer: ${_getOptionText(question, userAnswer!.selectedOptionId!)}',
                              style: TextStyle(
                                color: userAnswer.isCorrect ? Colors.green : Colors.red,
                              ),
                            ),
                          ] else ...[
                            const Text(
                              'Skipped',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ],
                          if (userAnswer == null || (!userAnswer.isCorrect)) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Correct answer: ${_getOptionText(question, question.correctOptionId)}',
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _getOptionText(Question question, String optionId) {
    final option = question.options.firstWhere(
      (option) => option.id == optionId,
      orElse: () => const Option(id: '', text: 'Unknown'),
    );
    return option.text;
  }

  Color _getAnswerStatusColor(UserAnswer? userAnswer) {
    if (userAnswer == null || userAnswer.selectedOptionId == null) {
      return Colors.orange;
    }
    return userAnswer.isCorrect ? Colors.green : Colors.red;
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 80) {
      return Colors.green;
    } else if (percentage >= 60) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String _getScoreMessage(double percentage) {
    if (percentage >= 80) {
      return 'Excellent! You have a great understanding of the topic.';
    } else if (percentage >= 60) {
      return 'Good job! You\'ve got a solid grasp of the material.';
    } else if (percentage >= 40) {
      return 'Not bad, but there\'s room for improvement.';
    } else {
      return 'You might want to revisit the topic and try again.';
    }
  }

  void _tryAgain(BuildContext context) {
    context.read<QuizCubit>().restartQuiz();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const QuizScreen(),
      ),
    );
  }

  void _navigateToWelcomeScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
      (route) => false,
    );
  }
}