class ConfigModel {
  final double pricepoint;

  ConfigModel({required this.pricepoint});

  factory ConfigModel.fromFirebase(Map map) {
    return ConfigModel(
        pricepoint: double.parse((map["pricepoint"] ?? "0.0").toString()));
  }
}
