import 'package:ambient/data/autentication_services.dart';
import 'package:ambient/domain/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  final AutenticationServices _autenticationServices;
  GeneralCubit(AutenticationServices autenticationServices)
      : _autenticationServices = autenticationServices,
        super(GeneralInitial());

  int _currentNavigation = 0;
  UserModel get usermodelCubit => _autenticationServices.userModel;
  int get currentNavigation => _currentNavigation;

  set currentNavigation(value) {
    _currentNavigation = value;
    print(_currentNavigation);
  }
}
