import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';

class QuizRepository {
  // In a real application, this could fetch from an API or database
  Future<List<Question>> getQuestions() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Sample questions (in production, load from API or asset)
    final questions = [
      const Question(
        id: 'q1',
        text: 'What is Flutter?',
        options: [
          Option(id: 'a', text: 'A UI toolkit for building natively compiled applications'),
          Option(id: 'b', text: 'A database management system'),
          Option(id: 'c', text: 'A programming language'),
          Option(id: 'd', text: 'An operating system'),
        ],
        correctOptionId: 'a',
        timeLimit: 30,
      ),
      const Question(
        id: 'q2',
        text: 'Which programming language is used for Flutter development?',
        options: [
          Option(id: 'a', text: 'Java'),
          Option(id: 'b', text: 'Kotlin'),
          Option(id: 'c', text: 'Swift'),
          Option(id: 'd', text: 'Dart'),
        ],
        correctOptionId: 'd',
        timeLimit: 20,
      ),
      const Question(
        id: 'q3',
        text: 'What is a Widget in Flutter?',
        options: [
          Option(id: 'a', text: 'A database element'),
          Option(id: 'b', text: 'A UI component'),
          Option(id: 'c', text: 'A testing framework'),
          Option(id: 'd', text: 'A performance monitoring tool'),
        ],
        correctOptionId: 'b',
        timeLimit: 25,
      ),
      const Question(
        id: 'q4',
        text: 'Which of the following is a state management solution in Flutter?',
        options: [
          Option(id: 'a', text: 'SQLite'),
          Option(id: 'b', text: 'Firebase'),
          Option(id: 'c', text: 'Cubit'),
          Option(id: 'd', text: 'RestAPI'),
        ],
        correctOptionId: 'c',
        timeLimit: 30,
      ),
      const Question(
        id: 'q5',
        text: 'What is "hot reload" in Flutter?',
        options: [
          Option(id: 'a', text: 'A feature to quickly see code changes without restarting the app'),
          Option(id: 'b', text: 'A performance optimization technique'),
          Option(id: 'c', text: 'An animation effect'),
          Option(id: 'd', text: 'A unit testing framework'),
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
    debugPrint('Result saved: $result');
  }
}