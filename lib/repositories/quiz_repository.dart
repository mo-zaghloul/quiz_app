import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quiz_app/models/question.dart';

class QuizRepository {
  // In a real application, this could fetch from an API or database
  Future<List<Question>> getQuestions() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Sample questions (in production, load from API or asset)
    final questions = [
      Question(
        id: 'q1',
        text: 'What is Flutter?',
        options: [
          const Option(id: 'a', text: 'A UI toolkit for building natively compiled applications'),
          const Option(id: 'b', text: 'A database management system'),
          const Option(id: 'c', text: 'A programming language'),
          const Option(id: 'd', text: 'An operating system'),
        ],
        correctOptionId: 'a',
        timeLimit: 30,
      ),
      Question(
        id: 'q2',
        text: 'Which programming language is used for Flutter development?',
        options: [
          const Option(id: 'a', text: 'Java'),
          const Option(id: 'b', text: 'Kotlin'),
          const Option(id: 'c', text: 'Swift'),
          const Option(id: 'd', text: 'Dart'),
        ],
        correctOptionId: 'd',
        timeLimit: 20,
      ),
      Question(
        id: 'q3',
        text: 'What is a Widget in Flutter?',
        options: [
          const Option(id: 'a', text: 'A database element'),
          const Option(id: 'b', text: 'A UI component'),
          const Option(id: 'c', text: 'A testing framework'),
          const Option(id: 'd', text: 'A performance monitoring tool'),
        ],
        correctOptionId: 'b',
        timeLimit: 25,
      ),
      Question(
        id: 'q4',
        text: 'Which of the following is a state management solution in Flutter?',
        options: [
          const Option(id: 'a', text: 'SQLite'),
          const Option(id: 'b', text: 'Firebase'),
          const Option(id: 'c', text: 'Cubit'),
          const Option(id: 'd', text: 'RestAPI'),
        ],
        correctOptionId: 'c',
        timeLimit: 30,
      ),
      Question(
        id: 'q5',
        text: 'What is "hot reload" in Flutter?',
        options: [
          const Option(id: 'a', text: 'A feature to quickly see code changes without restarting the app'),
          const Option(id: 'b', text: 'A performance optimization technique'),
          const Option(id: 'c', text: 'An animation effect'),
          const Option(id: 'd', text: 'A unit testing framework'),
        ],
        correctOptionId: 'a',
        timeLimit: 35,
      ),
    ];

    return questions;
  }

  // In the future, this could store results to an API or local storage
  Future<void> saveResult(Map<String, dynamic> result) async {
    // Implement persistence logic here
    await Future.delayed(const Duration(milliseconds: 500));
    print('Result saved: $result');
  }
}