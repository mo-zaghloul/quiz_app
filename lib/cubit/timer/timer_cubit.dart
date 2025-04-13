import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/cubit/timer/timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  Timer? _timer;
  final void Function()? onTimerComplete;

  TimerCubit({this.onTimerComplete}) : super(const TimerState());

  void startTimer(int seconds) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }

    emit(TimerState(
      duration: seconds,
      remaining: seconds,
      status: TimerStatus.running,
    ));

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tickTimer();
    });
  }

  void _tickTimer() {
    final currentState = state;
    
    if (currentState.remaining <= 1) {
      _complete();
    } else {
      emit(currentState.copyWith(
        remaining: currentState.remaining - 1,
      ));
    }
  }

  void pauseTimer() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
      emit(state.copyWith(status: TimerStatus.paused));
    }
  }

  void resumeTimer() {
    if (state.status == TimerStatus.paused) {
      emit(state.copyWith(status: TimerStatus.running));
      
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        _tickTimer();
      });
    }
  }

  void resetTimer() {
    _timer?.cancel();
    emit(const TimerState());
  }

  void _complete() {
    _timer?.cancel();
    emit(state.copyWith(
      remaining: 0,
      status: TimerStatus.completed,
    ));
    
    if (onTimerComplete != null) {
      onTimerComplete!();
    }
  }

  int getElapsedTime() {
    return state.duration - state.remaining;
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}