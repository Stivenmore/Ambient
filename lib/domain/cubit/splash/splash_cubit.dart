import 'package:ambient/data/autentication_services.dart';
import 'package:ambient/domain/services/prefs_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AutenticationServices _autenticationServices;
  SplashCubit(AutenticationServices autenticationServices)
      : _autenticationServices = autenticationServices,
        super(SplashLoading());

  final prefs = UserPreferences();

  Future getUser() async {
    emit(SplashLoading());
    if (prefs.token.isNotEmpty) {
      final resp = await _autenticationServices.getUser(prefs.token);
      if (resp["bool"]) {
        emit(SplashSuccess());
      } else {
        emit(SplashError());
      }
    } else {
      emit(SplashError());
    }
  }
}
