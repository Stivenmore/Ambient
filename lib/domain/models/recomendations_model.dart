class RecomendationsModel {
  final String id;
  final String img;
  final String name;
  final String podcast;
  final dynamic ref;
  final String type;
  final String description;
  final String upload;

  RecomendationsModel(
      {required this.id,
      required this.img,
      required this.name,
      required this.podcast,
      required this.ref,
      required this.type,
      required this.description,
      required this.upload});

  factory RecomendationsModel.fromFirebase(Map<String, dynamic> map) {
    return RecomendationsModel(
      id: map["id"] as String? ?? "",
      img: map["img"] as String? ?? "",
      name: map["name"] as String? ?? "",
      podcast: map["podcast"] as String? ?? "",
      ref: map["ref"] ?? "",
      type: map["type"] as String? ?? "N/A",
      description: map["description"] as String? ?? "",
      upload: map["update"] as String? ?? "",
    );
  }
}
