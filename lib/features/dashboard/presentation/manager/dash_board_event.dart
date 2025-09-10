part of 'dash_board_bloc.dart';

sealed class DashBoardEvent {}

final class PickUserImageEvent extends DashBoardEvent {}
final class ChangeUserImageEvent extends DashBoardEvent {}
final class UpdateUserEvent extends DashBoardEvent {}



