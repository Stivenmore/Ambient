part of 'benefics_cubit.dart';

enum StockModelEnum { none, error, success, loading }

enum ConfigModelEnum { none, error, success, loading }

class BeneficsState extends Equatable {
  late final List<StockModel> stockmodel;
  late final List<ConfigModel> configmodel;
  late final StockModelEnum stockModelEnum;
  late final ConfigModelEnum configModelEnum;

  BeneficsState({
    List<StockModel>? stockmodel,
    List<ConfigModel>? configmodel,
    StockModelEnum? stockModelEnum,
    ConfigModelEnum? configModelEnum,
  }) {
    this.configModelEnum = configModelEnum ?? ConfigModelEnum.none;
    this.stockModelEnum = stockModelEnum ?? StockModelEnum.none;
    this.stockmodel = stockmodel ?? <StockModel>[];
    this.configmodel = configmodel ?? <ConfigModel>[];
  }

  BeneficsState copyWith({
    List<StockModel>? stockmodel,
    List<ConfigModel>? configmodel,
    StockModelEnum? stockModelEnum,
    ConfigModelEnum? configModelEnum,
  }) {
    return BeneficsState(
      configModelEnum: configModelEnum ?? this.configModelEnum,
      stockModelEnum: stockModelEnum ?? this.stockModelEnum,
      stockmodel: stockmodel ?? this.stockmodel,
      configmodel: configmodel ?? this.configmodel,
    );
  }

  @override
  List<Object?> get props =>
      [configModelEnum, configmodel, stockModelEnum, stockmodel];
}
