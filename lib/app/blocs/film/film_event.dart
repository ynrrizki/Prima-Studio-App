part of 'film_bloc.dart';

abstract class FilmEvent extends Equatable {
  const FilmEvent();

  @override
  List<Object> get props => [];
}

// FILM
class LoadFilm extends FilmEvent {
  final dynamic field;
  final Object? isEqualTo;
  final Object? isNotEqualTo;
  final Object? isLessThan;
  final Object? isLessThanOrEqualTo;
  final Object? isGreaterThan;
  final Object? isGreaterThanOrEqualTo;
  final Object? arrayContains;
  final List<Object?>? arrayContainsAny;
  final List<Object?>? whereIn;
  final List<Object?>? whereNotIn;
  final bool? isNull;

  const LoadFilm({
    this.field,
    this.isEqualTo,
    this.isNotEqualTo,
    this.isLessThan,
    this.isLessThanOrEqualTo,
    this.isGreaterThan,
    this.isGreaterThanOrEqualTo,
    this.arrayContains,
    this.arrayContainsAny,
    this.whereIn,
    this.whereNotIn,
    this.isNull,
  });

  @override
  List<Object> get props => [
        field!,
        isEqualTo!,
        isNotEqualTo!,
        isLessThan!,
        isLessThanOrEqualTo!,
        isGreaterThan!,
        isGreaterThanOrEqualTo!,
        arrayContains!,
        arrayContainsAny!,
        whereIn!,
        whereNotIn!,
        isNull!,
      ];
}

class UpdateFilm extends FilmEvent {
  final List<Film> films;

  const UpdateFilm(this.films);

  @override
  List<Object> get props => [films];
}

// RATING
class LoadRating extends FilmEvent {
  final Film film;
  const LoadRating({
    required this.film,
  });

  @override
  List<Object> get props => [film];
}

class UpdateRating extends FilmEvent {
  final double rating;

  const UpdateRating({required this.rating});

  @override
  List<Object> get props => [rating];
}

// RATING BY USER
class LoadRatingByUser extends FilmEvent {
  final Film film;
  const LoadRatingByUser({
    required this.film,
  });

  @override
  List<Object> get props => [film];
}

class UpdateRatingByUser extends FilmEvent {
  final double rating;
  const UpdateRatingByUser({required this.rating});

  @override
  List<Object> get props => [rating];
}

class AddRating extends FilmEvent {
  final Film film;
  final num value;
  const AddRating({
    required this.film,
    required this.value,
  });

  @override
  List<Object> get props => [film, value];
}
