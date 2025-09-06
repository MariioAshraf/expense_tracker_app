part of 'dash_board_bloc.dart';

sealed class DashBoardState {}

final class DashBoardInitial extends DashBoardState {}

final class PickProfilePhotoSuccess extends DashBoardState {}

final class ChangeProfilePhotoLoading extends DashBoardState {}

final class ChangeProfilePhotoSuccess extends DashBoardState {
  final String profileImageUrl;

  ChangeProfilePhotoSuccess(this.profileImageUrl);
}

final class ChangeProfilePhotoFailure extends DashBoardState {
  final String message;

  ChangeProfilePhotoFailure(this.message);
}
