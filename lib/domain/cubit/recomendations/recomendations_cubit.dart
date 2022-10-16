import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ambient/data/home_services.dart';
import 'package:ambient/domain/models/recomendations_model.dart';

part 'recomendations_state.dart';

class RecomendationsCubit extends Cubit<RecomendationsState> {
  final HomeServices _homeServices;
  RecomendationsCubit(HomeServices homeServices)
      : _homeServices = homeServices,
        super(RecomendationsLoading());

  Future getRecomendations() async {
    try {
      emit(RecomendationsLoading());
      List<RecomendationsModel> list = await _homeServices.getRecomendations();
      emit(RecomendationsSuccess(list));
    } catch (e) {
      emit(RecomendationsError());
    }
  }
}
