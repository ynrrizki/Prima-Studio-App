part of 'film_bloc.dart';

// enum FilmStatus { initial, success, failure }

class FilmState extends Equatable {
  const FilmState();
  @override
  List<Object> get props => [];
}

class FilmLoading extends FilmState {}

class FilmLoaded extends FilmState {
  final List<Film> films;

  const FilmLoaded({this.films = const <Film>[]});

  @override
  List<Object> get props => [films];
}

class RatingLoading extends FilmState {}

class RatingLoaded extends FilmState {
  final double rating;

  const RatingLoaded({required this.rating});

  @override
  List<Object> get props => [rating];
}

class RatingByUserLoading extends FilmState {}

class RatingByUserLoaded extends FilmState {
  final double rating;

  const RatingByUserLoaded({required this.rating});

  @override
  List<Object> get props => [rating];
}
