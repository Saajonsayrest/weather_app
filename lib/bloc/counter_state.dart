// part of 'counter_bloc.dart';

import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  const CounterState({required this.counter});

  final int counter;

  @override
  List<Object?> get props => [counter];

  Map<String, dynamic> toMap() {
    return {'counter': counter};
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(counter: map['counter'].toInt() ?? 0);
  }
}

class CounterInitial extends CounterState {
  const CounterInitial() : super(counter: 0);
}

class IncrementState extends CounterState {
  const IncrementState(int increasedValue) : super(counter: increasedValue);
}

class DecrementState extends CounterState {
  const DecrementState(int decreasedValue) : super(counter: decreasedValue);
}
