import 'package:flutter/material.dart';

class StatisticObj {
  final List obj;

  StatisticObj({required this.obj});

  factory StatisticObj.fromFirebase(Map map) {
    List<String> data = [];
    map.forEach((key, value) {
      data.add("$key-$value");
    });
    return StatisticObj(obj: data);
  }
}

class StatisticObjLocal {
  final String name;
  final double value;
  final Color value2;

  StatisticObjLocal(
      {required this.name, required this.value, required this.value2});
}
