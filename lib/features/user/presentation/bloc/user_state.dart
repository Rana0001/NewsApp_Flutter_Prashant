part of 'user_bloc.dart';

class UserState extends Equatable {
  final UserModel userModel;
  const UserState({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

final class UserLoading extends UserState {
  const UserLoading({required super.userModel});
}

final class UserSuccess extends UserState {
  @override
  final UserModel userModel;
  const UserSuccess({required this.userModel}) : super(userModel: userModel);
}

final class UserError extends UserState {
  const UserError({required super.userModel});
}
