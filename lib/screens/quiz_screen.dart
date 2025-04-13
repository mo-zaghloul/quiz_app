import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/cubit/quiz/quiz_cubit.dart';
import 'package:quiz_app/cubit/quiz/quiz_state.dart';
import 'package:quiz_app/cubit/timer/timer_cubit.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:quiz_app/widgets/question_card.dart';
import 'package:quiz_app/widgets/timer_display.dart';
import 'package:quiz_app/widgets/navigation_buttons.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;        
        _showExitConfirmationDialog(context);
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          title: const Text('Quiz'),
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _showExitConfirmationDialog(context),
          ),
        ),
        body: BlocConsumer<QuizCubit, QuizState>(
          listener: (context, state) {
            if (state.status == QuizStatus.completed) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ResultScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status == QuizStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.status == QuizStatus.error || state.currentQuestion == null) {
              return _buildErrorWidget(state.error ?? 'Something went wrong');
            }

            // Start the timer when a question is displayed
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<TimerCubit>().startTimer(state.currentQuestion?.timeLimit ?? 30);
            });

            return SafeArea(
              child: Column(
                children: [
                  const TimerDisplay(),
                  Expanded(
                    child: QuestionCard(
                      question: state.currentQuestion!,
                      onOptionSelected: (optionId) {
                        context.read<QuizCubit>().answerQuestion(
                              optionId,
                              context.read<TimerCubit>().getElapsedTime(),
                            );
                      },
                    ),
                  ),
                  NavigationButtons(
                    showSkip: true,
                    onSkip: () {
                      context.read<QuizCubit>().skipQuestion(
                            context.read<TimerCubit>().getElapsedTime(),
                          );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              'Error',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<QuizCubit>().loadQuestions();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quit Quiz?'),
        content: const Text(
          'Are you sure you want to exit? Your progress will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<TimerCubit>().resetTimer();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}