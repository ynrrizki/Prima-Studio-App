import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:prima_studio/app/models/models.dart';
import 'package:prima_studio/app/repositories/user/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void setProfileUser({
    required String name,
    required String description,
  }) async {
    try {
      User user = const User().copyWith(
        id: auth.FirebaseAuth.instance.currentUser!.uid,
        email: auth.FirebaseAuth.instance.currentUser!.email!,
        name: name,
        description: description,
      );

      return await UserRepository().createUser(user);
    } catch (_) {}
  }
}
