part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

// FETCH PROFILE
class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final User user;
  const UpdateProfile({required this.user});

  @override
  List<Object> get props => [user];
}

// EDIT PROFILE
class EditProfile extends ProfileEvent {
  final User user;
  const EditProfile({required this.user});

  @override
  List<Object> get props => [user];
}
