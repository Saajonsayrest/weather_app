import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_app/bloc/counter_event.dart';
import 'package:weather_app/bloc/counter_state.dart';

class CounterBloc extends HydratedBloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitial()) {
    on<CounterIncrementEvent>(
        (event, emit) => emit(IncrementState(state.counter + 1)));
    on<CounterDecrementEvent>(
        (event, emit) => emit(DecrementState(state.counter - 1)));
  }

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return state.toMap();
  }
}
