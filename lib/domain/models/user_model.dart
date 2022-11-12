import 'package:ambient/domain/models/statistic_glob.dart';
import 'package:ambient/domain/models/statistic_obt.dart';
import 'package:ambient/screens/utils/theme.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String nombre;
  final String email;
  final int points;
  final List<Transaction> transaction;
  final StatisticObj reciclajeObj;
  final StatisticGlob statisticGlob;

  UserModel(
      {required this.nombre,
      required this.email,
      required this.reciclajeObj,
      required this.statisticGlob,
      required this.points,
      required this.transaction});

  factory UserModel.fromFirebase(Map<String, dynamic> map) {
    return UserModel(
        nombre: map["name"] as String? ?? "",
        email: map["email"] as String? ?? "",
        points: map["point"] as int? ?? 0,
        reciclajeObj: StatisticObj.fromFirebase(
          map["statistics"] as Map? ?? {},
        ),
        statisticGlob: StatisticGlob.fromFirebase(
          map["GlobalStatistic"] as Map? ?? {},
        ),
        transaction: (map["pointList"] as Iterable)
            .map((e) => Transaction.fromJson(e))
            .toList());
  }
}

class Transaction {
  final int point;
  final String time;
  final Icon icon;
  final Color color;

  Transaction(
      {required this.icon,
      required this.point,
      required this.time,
      required this.color});

  factory Transaction.fromJson(Map map) {
    final type = {
      "up": const Icon(
        Icons.airline_stops_rounded,
        color: Colors.green,
      ),
      "down": const Icon(
        Icons.arrow_downward_sharp,
        color: Colors.red,
      ),
      "none": Icon(
        Icons.anchor_outlined,
        color: UniCodes.blueperformance,
      )
    };

    final color = {
      "up": Colors.green,
      "down": Colors.red,
      "none": UniCodes.blueperformance
    };
    return Transaction(
        point: map["point"] as int? ?? 0,
        time: map["time"] as String? ?? "",
        icon: type[(map["type"] as String? ?? "none")]!,
        color: color[(map["type"] as String? ?? "none")]!);
  }
}
