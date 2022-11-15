import 'package:ambient/data/autentication_services.dart';
import 'package:ambient/domain/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  final AutenticationServices _autenticationServices;
  GeneralCubit(AutenticationServices autenticationServices)
      : _autenticationServices = autenticationServices,
        super(GeneralState());

  late String urlImg;

  int _currentNavigation = 0;
  int _lastNavigation = 0;
  UserModel get usermodelCubit => _autenticationServices.userModel;
  int get currentNavigation => _currentNavigation;

  set currentNavigation(value) {
    _lastNavigation = _currentNavigation;
    _currentNavigation = value;
  }

  void lastnavigation() {
    _currentNavigation = _lastNavigation;
  }

  void resetState() {
    emit(state.copyWith(generalStateUserPhoto: GeneralStateUserPhoto.none));
  }

  Future getImageUser() async {
    emit(state.copyWith(generalStateUserPhoto: GeneralStateUserPhoto.loading));
    try {
      final Map? file = await getImage();
      if (file != null) {
        urlImg = await _autenticationServices.setImage(
            name: file["file"], fileBytes: file["bytes"]);
        if (urlImg.isNotEmpty) {
          emit(state.copyWith(
              generalStateUserPhoto: GeneralStateUserPhoto.success));
        } else {
          emit(state.copyWith(
              generalStateUserPhoto: GeneralStateUserPhoto.error));
        }
      } else {
        emit(
            state.copyWith(generalStateUserPhoto: GeneralStateUserPhoto.error));
      }
    } catch (e) {
      emit(state.copyWith(generalStateUserPhoto: GeneralStateUserPhoto.error));
    }
  }

  Future updateUser(UserModel user) async {
    emit(state.copyWith(update: GeneralStateUserUpdate.loading));
    try {
      final resp = await _autenticationServices.updateUser(
          addres: user.address,
          name: user.nombre,
          phone: user.phone,
          id: user.id!,
          activate: user.activate!);
      if (resp == true) {
        emit(state.copyWith(update: GeneralStateUserUpdate.success));
      } else {
        emit(state.copyWith(update: GeneralStateUserUpdate.error));
      }
    } catch (e) {
      emit(state.copyWith(update: GeneralStateUserUpdate.error));
    }
  }

  getImage() async {
    final currentImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (currentImage != null) {
      String file = currentImage.name;
      Uint8List fileBytes = await currentImage.readAsBytes();
      return {"file": file, "bytes": fileBytes};
    } else {
      return null;
    }
  }
}
