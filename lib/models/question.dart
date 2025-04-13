import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String id;
  final String text;
  final List<Option> options;
  final String correctOptionId;
  final int timeLimit; // in seconds

  const Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOptionId,
    this.timeLimit = 30,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      text: json['text'],
      options: (json['options'] as List)
          .map((option) => Option.fromJson(option))
          .toList(),
      correctOptionId: json['correctOptionId'],
      timeLimit: json['timeLimit'] ?? 30,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'options': options.map((option) => option.toJson()).toList(),
      'correctOptionId': correctOptionId,
      'timeLimit': timeLimit,
    };
  }

  @override
  List<Object?> get props => [id, text, options, correctOptionId, timeLimit];
}

class Option extends Equatable {
  final String id;
  final String text;

  const Option({
    required this.id,
    required this.text,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }

  @override
  List<Object?> get props => [id, text];
}