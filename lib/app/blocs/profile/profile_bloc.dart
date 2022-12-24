import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prima_studio/app/models/models.dart';
import 'package:prima_studio/app/repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  StreamSubscription? _profileSubscription;

  ProfileBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ProfileLoading()) {
    on<ProfileEvent>((event, emit) {
      if (event is LoadProfile) {
        _onLoadProfileToState();
      } else if (event is UpdateProfile) {
        _onUpdateProfileToState(event, emit);
      }
    });

    on<EditProfile>((event, emit) async {
      await _userRepository.updateUser(event.user);
    });
  }

  void _onLoadProfileToState() {
    _profileSubscription?.cancel();
    _profileSubscription = _userRepository.getUser().listen((user) {
      return add(UpdateProfile(user: user));
    });
  }

  void _onUpdateProfileToState(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) {
    emit(ProfileLoaded(user: event.user));
  }

  // @override
  // Future<void> close() async {
  //   _profileSubscription?.cancel();
  //   super.close();
  // }
}
