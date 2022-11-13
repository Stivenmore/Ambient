import 'package:ambient/data/home_services.dart';
import 'package:ambient/domain/models/howtoprepared_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'howtoprepared_state.dart';

class HowtopreparedCubit extends Cubit<HowtopreparedState> {
  final HomeServices _homeServices;
  HowtopreparedCubit(HomeServices homeServices)
      : _homeServices = homeServices,
        super(HowtopreparedInitial());

  Future getAllHowToprepared() async {
    emit(HowtopreparedLoading());
    try {
      List<HowToPreparedModel> resp = await _homeServices.getHowToPrepared();
      emit(HowtopreparedLoaded(howtoprepared: resp));
    } catch (e) {
      emit(const HowtopreparedError(error: "Error"));
    }
  }

  Future getForTypeHowToprepared(String type) async {
    emit(HowtopreparedLoading());
    try {
      List<HowToPreparedModel> resp =
          await _homeServices.getHowToPreparedType(type);
      emit(HowtopreparedLoaded(howtoprepared: resp));
    } catch (e) {
      emit(const HowtopreparedError(error: "Error"));
    }
  }
}
