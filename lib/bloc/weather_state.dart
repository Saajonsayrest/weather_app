part of 'weather_bloc.dart';

abstract class WeatherBlocState extends Equatable {
  const WeatherBlocState();
}

class WeatherBlocInitial extends WeatherBlocState {
  @override
  List<Object?> get props => [];
}

class WeatherBlocLoading extends WeatherBlocState {
  @override
  List<Object?> get props => [];
}

class WeatherBlocFailure extends WeatherBlocState {
  @override
  List<Object?> get props => [];
}

class WeatherBlocSuccess extends WeatherBlocState {
  const WeatherBlocSuccess(this.weather);

  final Weather weather;

  @override
  List<Object?> get props => [weather];
}
