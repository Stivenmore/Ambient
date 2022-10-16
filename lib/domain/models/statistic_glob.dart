class StatisticGlob {
  final List<String> obj;

  StatisticGlob({required this.obj});

  factory StatisticGlob.fromFirebase(Map map) {
    List<String> data = [];
    map.forEach((key, value) {
      data.add("$key-$value");
    });
    return StatisticGlob(obj: data);
  }
}

class StatisticGlobLocal {
  final String name;
  final int value;
  final int value2;

  StatisticGlobLocal(
      {required this.name, required this.value, required this.value2});
}
