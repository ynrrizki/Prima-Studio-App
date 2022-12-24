import 'package:prima_studio/app/models/film.dart';

class FilmAllArguments {
  final bool isComingSoon;
  final List<Film> film;
  FilmAllArguments({required this.film, this.isComingSoon = false});
}
