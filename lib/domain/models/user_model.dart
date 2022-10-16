import 'package:ambient/domain/models/statistic_glob.dart';
import 'package:ambient/domain/models/statistic_obt.dart';

class UserModel {
  final String nombre;
  final String email;
  final StatisticObj reciclajeObj;
  final StatisticGlob statisticGlob;

  UserModel(
      {required this.nombre,
      required this.email,
      required this.reciclajeObj,
      required this.statisticGlob});

  factory UserModel.fromFirebase(Map<String, dynamic> map) {
    return UserModel(
        nombre: map["name"] as String? ?? "",
        email: map["email"] as String? ?? "",
        reciclajeObj: StatisticObj.fromFirebase(
          map["statistics"] as Map? ?? {},
        ),
        statisticGlob: StatisticGlob.fromFirebase(
          map["GlobalStatistic"] as Map? ?? {},
        ));
  }
}
