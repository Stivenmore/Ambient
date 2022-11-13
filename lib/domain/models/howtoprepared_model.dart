class HowToPreparedModel {
  final String name;
  final String type;
  final String url;
  final String time;

  HowToPreparedModel(
      {required this.name,
      required this.type,
      required this.url,
      required this.time});

  factory HowToPreparedModel.fromFirebase(Map map) {
    return HowToPreparedModel(
        name: map["name"] as String? ?? "...",
        type: map["type"] as String? ?? "...",
        time: map["time"] as String? ?? "...",
        url: map["url"] as String? ??
            "https://www.youtube.com/watch?v=cvakvfXj0KE");
  }
}
