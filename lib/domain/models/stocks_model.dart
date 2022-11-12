class StockModel {
  final double carton;
  final double metal;
  final double vidrio;
  final double papel;
  final double plastico;
  final String update;

  StockModel(
      {required this.carton,
      required this.metal,
      required this.papel,
      required this.plastico,
      required this.update,
      required this.vidrio});

  factory StockModel.fromFirebase(Map map) {
    return StockModel(
        carton: double.parse((map["carton"] ?? "0.0").toString()),
        metal: double.parse((map["metal"] ?? "0.0").toString()),
        papel: double.parse((map["papel"] ?? "0.0").toString()),
        plastico: double.parse((map["plastico"] ?? "0.0").toString()),
        update: map["update"] ?? "",
        vidrio: double.parse((map["vidrio"] ?? "0.0").toString()));
  }
}
