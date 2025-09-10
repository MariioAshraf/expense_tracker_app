part of 'dash_board_bloc.dart';

sealed class DashBoardState {}

final class DashBoardInitial extends DashBoardState {}

final class PickProfilePhotoSuccess extends DashBoardState {}

final class ChangeProfilePhotoLoading extends DashBoardState {}

final class UpdateUserSuccess extends DashBoardState {}

final class ChangeProfilePhotoSuccess extends DashBoardState {
  final String profileImageUrl;

  ChangeProfilePhotoSuccess(this.profileImageUrl);
}

final class ChangeProfilePhotoFailure extends DashBoardState {
  final String message;

  ChangeProfilePhotoFailure(this.message);
}

class DashBoardLoading extends DashBoardState {}

class DashBoardLoaded extends DashBoardState {
  final UserModel user;

  DashBoardLoaded(this.user);
}

class DashBoardError extends DashBoardState {
  final String message;

  DashBoardError(this.message);
}
