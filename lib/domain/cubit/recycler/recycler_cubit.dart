import 'package:ambient/data/home_services.dart';
import 'package:ambient/domain/models/recycler_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recycler_state.dart';

class RecyclerCubit extends Cubit<RecyclerState> {
  final HomeServices _homeServices;
  RecyclerCubit(HomeServices homeServices)
      : _homeServices = homeServices,
        super(RecyclerLoading());

  Future getRecyclerList() async {
    try {
      emit(RecyclerLoading());
      List<RecyclerModel> recyclerList = await _homeServices.getRecycler();
      emit(RecyclerSuccess(recyclerList));
    } catch (e) {
      emit(RecyclerError());
    }
  }
}
