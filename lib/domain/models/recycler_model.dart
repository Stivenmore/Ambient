class RecyclerModel {
  final String creator;
  final String description;
  final String name;
  final String img;
  final List<EpisodeModel> episodes;

  RecyclerModel(
      {required this.img,
      required this.name,
      required this.description,
      required this.creator,
      required this.episodes});

  factory RecyclerModel.fromFirebase(Map<String, dynamic> map) {
    return RecyclerModel(
        img: map["img"] as String? ?? "",
        name: map["name"] as String? ?? "",
        description: map["description"] as String? ?? "",
        creator: map["creator"] as String? ?? "",
        episodes: EpisodeModel.fromFirebaseList(map["Episode"]));
  }
}

class EpisodeModel {
  final List options;
  final String description;
  final String name;
  final String problem;

  EpisodeModel(
      {required this.problem,
      required this.name,
      required this.description,
      required this.options});

  factory EpisodeModel.fromFirebase(Map<String, dynamic> map) {
    return EpisodeModel(
        problem: map["problem"] as String? ?? "",
        name: map["name"] as String? ?? "",
        description: map["description"] as String? ?? "",
        options: map["Options"] as List? ?? []);
  }

  static List<EpisodeModel> fromFirebaseList(List map) {
    return map.map((e) => EpisodeModel.fromFirebase(e)).toList();
  }
}
