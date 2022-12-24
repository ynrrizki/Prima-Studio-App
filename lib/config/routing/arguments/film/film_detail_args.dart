import 'package:prima_studio/app/models/film.dart';

class FilmDetailArguments {
  FilmDetailArguments({
    required this.bannerTag,
    this.fabTag,
    this.isComingSoon = false,
    required this.film,
  });

  final Object bannerTag;
  Object? fabTag;
  final bool isComingSoon;
  final Film film;
}
