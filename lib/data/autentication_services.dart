import 'package:ambient/domain/models/statistic_glob.dart';
import 'package:ambient/domain/models/statistic_obt.dart';
import 'package:ambient/domain/models/user_model.dart';
import 'package:ambient/domain/services/prefs_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AutenticationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late UserModel userModel;
  String get userUid => _firebaseAuth.currentUser!.uid;

  bool get isAuth =>
      _firebaseAuth.currentUser != null &&
      _firebaseAuth.currentUser?.uid != null;

  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user!.uid.isNotEmpty) {
        final usercloud =
            await _firestore.collection('Users').doc(user.user!.uid).get();
        if (usercloud.exists) {
          UserPreferences().token = usercloud.id;
          userModel = UserModel.fromFirebase(usercloud.data()!);
          return {"bool": true, "message": ""};
        } else {
          return {"bool": false, "message": "Usuario no encontrado"};
        }
      } else {
        return {"bool": false, "message": "Usuario no encontrado"};
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> register(
      {required String email,
      required String password,
      required String fullname}) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user!.uid != '') {
        await _firestore.collection('Users').doc(credentials.user!.uid).set({
          'email': email,
          'name': fullname,
          'password': password,
          "statistic": {},
          "GlobalStatistic": {}
        });
        UserPreferences().token = credentials.user!.uid;
        userModel = UserModel.fromFirebase({
          "name": fullname,
          "email": email,
          "statistic": {},
          "GlobalStatistic": {}
        });
        return {"bool": true, "message": ""};
      } else {
        return {"bool": false, "message": "Usuario no encontrado"};
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> forget({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    }
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      UserPreferences().token = "";
      userModel = UserModel(
          nombre: "",
          email: "",
          reciclajeObj: StatisticObj(obj: []),
          statisticGlob: StatisticGlob(obj: []));
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map> getUser(String uid) async {
    try {
      final usercloud = await _firestore.collection('Users').doc(uid).get();
      if (usercloud.exists) {
        userModel = UserModel.fromFirebase(usercloud.data()!);
        return {"bool": true, "message": ""};
      } else {
        return {"bool": false, "message": "Usuario no encontrado"};
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
