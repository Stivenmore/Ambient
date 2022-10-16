import 'package:ambient/domain/models/recomendations_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RecomendationsModel>> getRecomendations() async {
    try {
      final colletionAll = await _firestore.collection("Recomendations").get();
      List<RecomendationsModel> recomendationsList = colletionAll.docs
          .map((e) => RecomendationsModel.fromFirebase(e.data()))
          .toList();
      return recomendationsList;
    } catch (e) {
      throw Exception(e);
    }
  }
}
