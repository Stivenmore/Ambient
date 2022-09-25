import 'package:ambient/data/autentication_services.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_state.dart';

class ForgotCubit extends Cubit<ForgotState> {
  final AutenticationServices _autenticationServices;
  ForgotCubit(AutenticationServices autenticationServices)
      : _autenticationServices = autenticationServices,
        super(ForgotInitial());

  Future sendEmail(String email) async {
    try {
      emit(ForgotLoading());
      await _autenticationServices.forget(email: email);
      emit(ForgotLoaded());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          emit(const ForgotError("Usuario no encontrado"));
          break;
        case "invalid-email":
          emit(const ForgotError("Correo invalido"));
          break;
        default:
          emit(const ForgotError("Error"));
      }
    }
  }
}
