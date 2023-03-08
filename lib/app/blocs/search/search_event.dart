part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class LoadSearch extends SearchEvent {}

class SearchFilm extends SearchEvent {
  final String title;
  final String genre;
  const SearchFilm({required this.title, required this.genre});

  @override
  List<Object> get props => [title];
}

class UpdateResult extends SearchEvent {
  final List<Film> films;
  const UpdateResult(this.films);

  @override
  List<Object> get props => [films];
}
