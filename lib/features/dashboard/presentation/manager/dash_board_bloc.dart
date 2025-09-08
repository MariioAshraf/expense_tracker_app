import 'dart:io';
import 'package:expense_tracker_app/features/auth/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/repos/dash_board_repo.dart';

part 'dash_board_event.dart';

part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  static DashBoardBloc get(context) => BlocProvider.of(context);
  late UserModel userModel;
  final DashBoardRepo dashBoardRepo;
  final categoryNameController = TextEditingController();
  final categoryCodeController = TextEditingController();

  DashBoardBloc({required this.dashBoardRepo}) : super(DashBoardInitial()) {
    on<PickUserImageEvent>(_onPickUserImage);
    on<ChangeUserImageEvent>(_onChangeUserImage);
  }

  String? profileImagePath;

  Future<void> _onPickUserImage(
    PickUserImageEvent event,
    Emitter<DashBoardState> emit,
  ) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImagePath = pickedFile.path;
      emit(PickProfilePhotoSuccess());
    }
  }

  Future<void> _onChangeUserImage(
      ChangeUserImageEvent event, Emitter<DashBoardState> emit) async {
    if (profileImagePath == null) {
      emit(ChangeProfilePhotoFailure("No image selected"));
      return;
    }

    emit(ChangeProfilePhotoLoading());

    final result = await dashBoardRepo.changeUserProfileImage(
      File(profileImagePath!),
      userModel.uId!,
    );

    result.fold(
      (failure) => emit(ChangeProfilePhotoFailure(failure.message)),
      (image) => emit(ChangeProfilePhotoSuccess(image)),
    );
  }
}
