part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Film> films;

  const SearchLoaded({this.films = const <Film>[]});

  @override
  List<Object> get props => [films];
}
