import 'package:equatable/equatable.dart';

enum TimerStatus { initial, running, paused, completed }

class TimerState extends Equatable {
  final int duration; // Total duration in seconds
  final int remaining; // Remaining time in seconds
  final TimerStatus status;

  const TimerState({
    this.duration = 0,
    this.remaining = 0,
    this.status = TimerStatus.initial,
  });

  TimerState copyWith({
    int? duration,
    int? remaining,
    TimerStatus? status,
  }) {
    return TimerState(
      duration: duration ?? this.duration,
      remaining: remaining ?? this.remaining,
      status: status ?? this.status,
    );
  }

  String get formattedTime {
    final minutes = (remaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (remaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  double get progress => duration > 0 ? remaining / duration : 0;

  bool get isRunning => status == TimerStatus.running;
  bool get isCompleted => status == TimerStatus.completed;
  bool get isWarning => remaining <= 5 && status == TimerStatus.running;

  @override
  List<Object?> get props => [duration, remaining, status];
}