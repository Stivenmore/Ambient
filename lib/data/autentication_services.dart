import 'package:ambient/domain/models/user_model.dart';
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

  Future<Map<String, dynamic>> login({required String email, required String password}) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user!.uid != '') {
        final usercloud =
            await _firestore.collection('Users').doc(user.user!.uid).get();
        if (usercloud.exists) {
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
        await _firestore
            .collection('Users')
            .doc(credentials.user!.uid)
            .set({'email': email, 'name': fullname, 'password': password});
        userModel = UserModel.fromFirebase({
          "name": fullname,
          "email": email,
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
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
