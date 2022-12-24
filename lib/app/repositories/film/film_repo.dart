import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prima_studio/app/models/film.dart';
import 'package:prima_studio/app/models/models.dart';
part 'repository.dart';

class FilmRepository extends Repository {
  final FirebaseFirestore _firebaseFirestore;

  FilmRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Film>> getAll(
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
    if (field != null) {
      return _firebaseFirestore
          .collection('film')
          .where(
            field,
            isEqualTo: isEqualTo,
            isNotEqualTo: isNotEqualTo,
            isLessThan: isLessThan,
            isLessThanOrEqualTo: isLessThanOrEqualTo,
            isGreaterThan: isGreaterThan,
            isGreaterThanOrEqualTo: isGreaterThan,
            arrayContains: arrayContains,
            arrayContainsAny: arrayContainsAny,
            whereIn: whereIn,
            whereNotIn: whereNotIn,
            isNull: isNull,
          )
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((docs) => Film.fromSnapshot(docs)).toList();
      });
    } else {
      return _firebaseFirestore.collection('film').snapshots().map((snapshot) {
        return snapshot.docs.map((docs) => Film.fromSnapshot(docs)).toList();
      });
    }
  }

  @override
  Stream<double> getRating(Film film) {
    return _firebaseFirestore
        .collection('film')
        .doc(film.id)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;
      double average = 0.0;
      if (data['starRating'] != null || data['starRating'] != {}) {
        dynamic rating =
            data['starRating'].entries.map((m) => m.value['rating']).toList();
        dynamic sum = rating.fold(0, (p, c) => p + c);
        average = 0.0;
        if (sum > 0) {
          average = sum / rating.length;
        }
      }
      return average;
    });
  }

  @override
  Stream<double> getRatingByUser(Film film) {
    dynamic uid = FirebaseAuth.instance.currentUser!.uid;
    return _firebaseFirestore
        .collection('film')
        .doc(film.id)
        .snapshots()
        .map((event) {
      final data = event.data() as Map<String, dynamic>;
      final ratingUser = data['starRating'][uid];
      return ratingUser != null ? ratingUser['rating'] : 0.0;
    });
  }

  @override
  Future<void> addRating(Film film, num value) {
    dynamic uid = FirebaseAuth.instance.currentUser!.uid;
    dynamic email = FirebaseAuth.instance.currentUser!.email;
    return _firebaseFirestore.collection('film').doc(film.id).set(
          film.toRating(uid, email, value),
          SetOptions(
            merge: true,
          ),
        );
  }

  @override
  Future<void> removeRating(Film film, num value) {
    dynamic uid = FirebaseAuth.instance.currentUser!.uid;
    dynamic email = FirebaseAuth.instance.currentUser!.email;
    return _firebaseFirestore.collection('film').doc(film.id).set(
          film.delRating(uid, email, value),
          SetOptions(
            merge: true,
          ),
        );
  }
}
