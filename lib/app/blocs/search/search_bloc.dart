import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prima_studio/app/blocs/blocs.dart';
import 'package:prima_studio/app/models/models.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final FilmBloc _filmBloc;
  StreamSubscription? _filmSubscription;

  SearchBloc({required FilmBloc filmBloc})
      : _filmBloc = filmBloc,
        super(SearchLoading()) {
    on<LoadSearch>(_onLoadSearch);
    on<SearchFilm>(_onSearchFilm);
    on<UpdateResult>(_onUpdateResult);
  }

  void _onLoadSearch(LoadSearch event, Emitter<SearchState> emit) {
    emit(SearchLoading());
  }

  void _onSearchFilm(SearchFilm event, Emitter<SearchState> emit) {
    List<Film> films = (_filmBloc.state as FilmLoaded).films;
    List<Film> searchResult = films;

    if (event.title.isNotEmpty) {
      searchResult = searchResult
          .where((film) =>
              film.title!.toLowerCase().contains(event.title.toLowerCase()))
          .toList();
      emit(SearchLoaded(films: searchResult));
    }

    if (event.genre.isNotEmpty) {
      searchResult = searchResult
          .where((film) =>
              film.genre!.toLowerCase().contains(event.genre.toLowerCase()))
          .toList();
      emit(SearchLoaded(films: searchResult));
    }

    emit(SearchLoaded(films: searchResult));
  }

  void _onUpdateResult(UpdateResult event, Emitter<SearchState> emit) {}

  @override
  Future<void> close() async {
    _filmSubscription?.cancel();
    super.close;
  }
}
