import 'package:ambient/data/home_services.dart';
import 'package:ambient/domain/models/config_model.dart';
import 'package:ambient/domain/models/stocks_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'benefics_state.dart';

class BeneficsCubit extends Cubit<BeneficsState> {
  final HomeServices _homeServices;
  BeneficsCubit(HomeServices homeServices)
      : _homeServices = homeServices,
        super(BeneficsState());

  Future getStocks() async {
    emit(state.copyWith(stockModelEnum: StockModelEnum.loading));
    try {
      final List<StockModel> resp = await _homeServices.getStocks();
      emit(state.copyWith(
          stockmodel: resp, stockModelEnum: StockModelEnum.success));
    } catch (e) {
      emit(state.copyWith(stockModelEnum: StockModelEnum.error));
    }
  }

  Future getConfig() async {
    emit(state.copyWith(configModelEnum: ConfigModelEnum.loading));
    try {
      final List<ConfigModel> resp = await _homeServices.getConfig();
      emit(state.copyWith(
          configmodel: resp, configModelEnum: ConfigModelEnum.success));
    } catch (e) {
      emit(state.copyWith(configModelEnum: ConfigModelEnum.error));
    }
  }
}
