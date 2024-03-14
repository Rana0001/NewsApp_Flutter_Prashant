part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoginUser extends UserEvent {
  const LoginUser();
}

class LogoutUser extends UserEvent {
  const LogoutUser();
}

class DeleteUser extends UserEvent {
  const DeleteUser();
}
