part of 'weather_bloc.dart';

abstract class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherBlocEvent {
  const FetchWeather(this.position);

  final Position position;

  @override
  List<Object> get props => [position];
}
