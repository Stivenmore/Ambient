import 'package:ambient/domain/models/recomendations_model.dart';
import 'package:ambient/domain/models/recycler_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RecomendationsModel>> getRecomendations() async {
    try {
      final collectionAll = await _firestore.collection("Recomendations").get();
      List<RecomendationsModel> recomendationsList = collectionAll.docs
          .map((e) => RecomendationsModel.fromFirebase(e.data()))
          .toList();
      return recomendationsList;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<RecyclerModel>> getRecycler() async {
    try {
      final collectionAll = await _firestore.collection("Recycler").get();
      List<RecyclerModel> recyclerList = collectionAll.docs
          .map((e) => RecyclerModel.fromFirebase(e.data()))
          .toList();
      return recyclerList;
    } catch (e) {
      throw Exception(e);
    }
  }
}
