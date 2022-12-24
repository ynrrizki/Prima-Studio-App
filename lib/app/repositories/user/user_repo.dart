import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:prima_studio/app/models/user.dart';
import 'package:prima_studio/app/repositories/user/repository.dart';

class UserRepository extends Repository {
  final auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  UserRepository({
    FirebaseFirestore? firebaseFirestore,
    auth.FirebaseAuth? firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;
  // https://asset.kompas.com/crops/vYKuJHktOTHehAJUuWCgm4Aa4iI=/220x149:1058x708/750x500/data/photo/2021/01/29/60137ea955f0c.png

  @override
  Future<void> createUser(User user) async {
    bool userExist =
        (await _firebaseFirestore.collection('users').doc(user.id).get())
            .exists;

    if (userExist) {
      return;
    } else {
      await _firebaseFirestore
          .collection('users')
          .doc(user.id)
          .set(user.toDocument());
    }
  }

  @override
  Future<User> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot =
          await _firebaseFirestore.collection('users').doc(id).get();
      return User(
        id: id,
        avatar: snapshot['avatar'],
        name: snapshot['name'],
        description: snapshot['description'],
        email: snapshot['email'],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<User> getUser() {
    return _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Future<void> updateUser(User user) async {
    print('ini adalah id: ${user.id}');
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toDocument());
  }
}
