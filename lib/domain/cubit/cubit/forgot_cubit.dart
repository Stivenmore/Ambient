import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'forgot_state.dart';

class ForgotCubit extends Cubit<ForgotState> {
  ForgotCubit() : super(ForgotInitial());
}
