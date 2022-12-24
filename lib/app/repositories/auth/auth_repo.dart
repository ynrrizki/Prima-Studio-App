// ignore: library_prefixes
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
// ignore: library_prefixes
import 'package:google_sign_in/google_sign_in.dart' as googleAuth;
import 'package:prima_studio/app/repositories/user/user_repo.dart';
import '../../models/user.dart';
import 'repository.dart';

class AuthRepository extends Repository {
  final firebaseAuth.FirebaseAuth _auth;
  final googleAuth.GoogleSignIn _googleSignIn;
  final UserRepository _userRepository;

  AuthRepository({
    firebaseAuth.FirebaseAuth? auth,
    googleAuth.GoogleSignIn? googleSignIn,
    required UserRepository userRepository,
  })  : _auth = auth ?? firebaseAuth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ??
            googleAuth.GoogleSignIn.standard(
              scopes: ['email'],
            ),
        _userRepository = userRepository;

  @override
  Stream<firebaseAuth.User?> get user => _auth.userChanges();

  @override
  Future<User> signIn({required String email, required String password}) async {
    try {
      firebaseAuth.UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = await UserRepository().getUserById(userCredential.user!.uid);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      googleAuth.GoogleSignInAccount? account = await _googleSignIn.signIn();
      User user;
      if (account != null) {
        googleAuth.GoogleSignInAuthentication auth =
            await account.authentication;
        firebaseAuth.OAuthCredential credential =
            firebaseAuth.GoogleAuthProvider.credential(
          accessToken: auth.accessToken,
          idToken: auth.idToken,
        );
        await _auth.signInWithCredential(credential);

        user = const User().copyWith(
          id: _auth.currentUser!.uid,
          avatar: _auth.currentUser!.photoURL!,
          name: _auth.currentUser!.displayName!,
          email: _auth.currentUser!.email!,
        );
        await _userRepository.createUser(user);
      } else {
        user = const User().copyWith(id: account!.id);
      }
      return user;
    } catch (e) {
      log(e.toString());
      throw Exception('Failed sign in with google');
    }
  }

  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      firebaseAuth.UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = User(
        id: userCredential.user!.uid,
        name: name,
        email: email,
      );
      await _userRepository.createUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
