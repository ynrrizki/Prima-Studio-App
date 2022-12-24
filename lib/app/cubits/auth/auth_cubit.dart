import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prima_studio/app/models/models.dart';
import 'package:prima_studio/app/repositories/auth/auth_repo.dart';
import 'package:prima_studio/app/repositories/user/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  // final auth.User currentUser = auth.FirebaseAuth.instance.currentUser!;
  final AuthRepository _authRepository;
  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial());
  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      await _authRepository.signIn(
        email: email,
        password: password,
      );
      emit(AuthSuccess());
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signInWithGoogle() async {
    try {
      // emit(AuthGoogleLoading());
      await _authRepository.signInWithGoogle();
      emit(AuthGoogleSuccess());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signUp({
    required String email,
    required String password,
    required String name,
    String avatar =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxZS7wCn5oU2LWaXISsoa-gsJnQjAWJYlznA&usqp=CAU',
  }) async {
    try {
      emit(AuthLoading());

      await _authRepository.signUp(
        name: name,
        email: email,
        password: password,
      );

      emit(AuthSuccess());
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await _authRepository.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUser(String id) async {
    try {
      final user = await UserRepository().getUserById(id);
      emit(AuthUser(user));
      // print('Ini nama sapeee: ${user.name}');
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
