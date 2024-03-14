import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:newsapp/features/user/data/data_storages/remote/user_remote_services.dart';
import 'package:newsapp/features/user/data/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRemoteServices userRemoteServices;
  UserBloc(this.userRemoteServices)
      : super(UserLoading(
            userModel:
                UserModel(uid: '', email: '', displayName: '', photoUrl: ''))) {
    on<LoginUser>(onLoginUser);
    on<LogoutUser>(onLogoutUser);
    on<DeleteUser>(onDeleteUser);
  }

  Future<void> onLoginUser(
    LoginUser event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading(
        userModel:
            UserModel(uid: '', email: '', displayName: '', photoUrl: '')));
    try {
      final user = await userRemoteServices.signInWithGoogle();
      if (user != null) {
        emit(UserSuccess(
            userModel: UserModel(
                uid: user.uid,
                email: user.email!,
                displayName: user.displayName!,
                photoUrl: user.photoURL!,
                dob: user.metadata.creationTime!)));
      }
    } catch (e) {
      emit(UserError(
          userModel: UserModel(
        uid: '',
        email: '',
        displayName: '',
        photoUrl: '',
      )));
    }
  }

  Future<void> onLogoutUser(
    LogoutUser event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading(
        userModel:
            UserModel(uid: '', email: '', displayName: '', photoUrl: '')));
    try {
      await userRemoteServices.signOut();
      emit(UserSuccess(
          userModel:
              UserModel(uid: '', email: '', displayName: '', photoUrl: '')));
    } catch (e) {
      emit(UserError(
          userModel:
              UserModel(uid: '', email: '', displayName: '', photoUrl: '')));
    }
  }

  Future<void> onDeleteUser(
    DeleteUser event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading(
        userModel:
            UserModel(uid: '', email: '', displayName: '', photoUrl: '')));
    try {
      await userRemoteServices.deleteAccount();
      emit(UserSuccess(
          userModel:
              UserModel(uid: '', email: '', displayName: '', photoUrl: '')));
    } catch (e) {
      emit(UserError(
          userModel:
              UserModel(uid: '', email: '', displayName: '', photoUrl: '')));
    }
  }
}
