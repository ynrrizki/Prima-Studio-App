import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../models/models.dart';

abstract class Repository {
  Stream<auth.User?> get user;

  Future<User> signIn({required String email, required String password});

  Future<void> signInWithGoogle();

  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> signOut() async {}
}
