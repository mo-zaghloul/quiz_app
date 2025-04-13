import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/cubit/quiz/quiz_cubit.dart';
import 'package:quiz_app/cubit/timer/timer_cubit.dart';
import 'package:quiz_app/repositories/quiz_repository.dart';
import 'package:quiz_app/screens/welcome_screen.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<QuizRepository>(
          create: (context) => QuizRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<QuizCubit>(
            create: (context) => QuizCubit(
              quizRepository: context.read<QuizRepository>(),
            ),
          ),
          BlocProvider<TimerCubit>(
            create: (context) => TimerCubit(
              onTimerComplete: () {
                context.read<QuizCubit>().timeExpired();
              },
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Quiz App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Roboto',
          ),
          home: const WelcomeScreen(),
        ),
      ),
    );
  }
}