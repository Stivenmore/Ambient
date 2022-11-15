import 'package:ambient/domain/models/statistic_glob.dart';
import 'package:ambient/domain/models/statistic_obt.dart';
import 'package:ambient/domain/models/user_model.dart';
import 'package:ambient/domain/services/prefs_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AutenticationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
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
        await _firestore.collection('Users').doc(user.user!.uid).set({
          "lastlogin": DateFormat("yyyy-MM-dd").format(DateTime.now()),
        }, SetOptions(merge: true));
        if (usercloud.exists) {
          UserPreferences().token = usercloud.id;
          Map<String, dynamic> newmap = usercloud.data()!;
          newmap.addAll({"id": user.user!.uid});
          userModel = UserModel.fromFirebase(newmap);
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
          "GlobalStatistic": {},
          "pointList": [
            {
              "point": 0,
              "time": DateFormat("yyyy-MM-dd").format(DateTime.now()),
              "type": "none"
            }
          ]
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
          points: <Point>[],
          nombre: "",
          email: "",
          reciclajeObj: StatisticObj(obj: []),
          statisticGlob: StatisticGlob(obj: []),
          transaction: [],
          recycler: <RecyclerModel>[],
          id: "",
          phone: "",
          address: "");
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future updateUser(
      {required String addres,
      required String name,
      required String phone,
      required String id,
      required bool activate}) async {
    try {
      await _firestore.collection("Users").doc(id).set({
        "address": addres,
        "phone": phone,
        "name": name,
        "activate": activate
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map> getUser(String uid) async {
    try {
      final usercloud = await _firestore.collection('Users').doc(uid).get();
      await _firestore.collection('Users').doc(uid).set({
        "lastlogin": DateFormat("yyyy-MM-dd").format(DateTime.now()),
      }, SetOptions(merge: true));
      if (usercloud.exists) {
        Map<String, dynamic> newmap = usercloud.data()!;
        newmap.addAll({"id": uid});
        userModel = UserModel.fromFirebase(newmap);
        return {"bool": true, "message": ""};
      } else {
        return {"bool": false, "message": "Usuario no encontrado"};
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future setImage({required String name, required Uint8List fileBytes}) async {
    final postImageRef = _storage.ref("users");
    late String state;
    final UploadTask uploadTask = postImageRef
        .child("${DateTime.now().millisecondsSinceEpoch}.jpeg")
        .putData(
            fileBytes,
            SettableMetadata(
              contentType: 'image/jpeg',
            ));
    return await (await uploadTask).ref.getDownloadURL();
  }
}
