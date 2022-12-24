import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prima_studio/app/models/film.dart';
import 'package:prima_studio/app/repositories/film/film_repo.dart';

part 'film_event.dart';
part 'film_state.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final FilmRepository _filmRepository;
  StreamSubscription? _filmSubscription;
  StreamSubscription? _ratingByUserSubscription;
  StreamSubscription? _ratingSubscription;

  FilmBloc({required FilmRepository filmRepository})
      : _filmRepository = filmRepository,
        super(FilmLoading()) {
    on<FilmEvent>((event, emit) {
      if (event is LoadFilm) {
        _onLoadFilmToState(
          event.field,
          isEqualTo: event.isEqualTo,
          isNotEqualTo: event.isNotEqualTo,
          isLessThan: event.isLessThan,
          isLessThanOrEqualTo: event.isLessThanOrEqualTo,
          isGreaterThan: event.isGreaterThan,
          isGreaterThanOrEqualTo: event.isGreaterThanOrEqualTo,
          arrayContains: event.arrayContains,
          arrayContainsAny: event.arrayContainsAny,
          whereIn: event.whereIn,
          whereNotIn: event.whereNotIn,
          isNull: event.isNull,
        );
      } else if (event is UpdateFilm) {
        _onUpdateFilmToState(event, emit);
      }

      if (event is LoadRating) {
        _onLoadRatingToState(event.film);
      } else if (event is UpdateRating) {
        _onUpdateRatingToState(event, emit);
      }

      if (event is LoadRatingByUser) {
        _onLoadRatingByUserToState(event.film);
      } else if (event is UpdateRatingByUser) {
        _onUpdateRatingByUserToState(event, emit);
      }
    });

    on<AddRating>((event, emit) async {
      await _filmRepository.addRating(event.film, event.value);
    });
  }

  void _onLoadFilmToState(
    Object? field, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    _filmSubscription?.cancel();
    _filmSubscription = _filmRepository
        .getAll(
      field,
      isEqualTo: isEqualTo,
      isNotEqualTo: isNotEqualTo,
      isLessThan: isLessThan,
      isLessThanOrEqualTo: isLessThanOrEqualTo,
      isGreaterThan: isGreaterThan,
      isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
      arrayContains: arrayContains,
      arrayContainsAny: arrayContainsAny,
      whereIn: whereIn,
      whereNotIn: whereNotIn,
      isNull: isNull,
    )
        .listen((film) {
      return add(UpdateFilm(film));
    });
  }

  void _onUpdateFilmToState(UpdateFilm event, Emitter<FilmState> emit) {
    emit(FilmLoaded(films: event.films));
  }

  void _onLoadRatingToState(Film film) {
    _ratingSubscription?.cancel();
    _ratingSubscription = _filmRepository.getRating(film).listen((rating) {
      return add(UpdateRating(rating: rating));
    });
  }

  void _onUpdateRatingToState(UpdateRating event, Emitter<FilmState> emit) {
    emit(RatingLoaded(rating: event.rating));
  }

  void _onLoadRatingByUserToState(Film film) {
    _ratingByUserSubscription?.cancel();
    _ratingByUserSubscription =
        _filmRepository.getRatingByUser(film).listen((rating) {
      return add(UpdateRatingByUser(rating: rating));
    });
  }

  void _onUpdateRatingByUserToState(
      UpdateRatingByUser event, Emitter<FilmState> emit) {
    emit(RatingByUserLoaded(rating: event.rating));
  }
}
