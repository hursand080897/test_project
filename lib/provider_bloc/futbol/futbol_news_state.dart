part of 'futbol_news_bloc.dart';

class FutbolNewsState {
  final List<ModelFutbol> listFutbol;
  FutbolNewsState({
    this.listFutbol = const [],
  });

  FutbolNewsState copyWith({
    List<ModelFutbol>? listFutbol,
  }) {
    return FutbolNewsState(
      listFutbol: listFutbol ?? this.listFutbol,
    );
  }
}
