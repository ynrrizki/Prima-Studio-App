part of 'film_repo.dart';

abstract class Repository<T> {
  Stream<List<T>> getAll(
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
  });
  Stream<double> getRating(Film film);
  Stream<double> getRatingByUser(Film film);
  Future<void> addRating(Film film, num value);
  Future<void> removeRating(Film film, num value);
}
