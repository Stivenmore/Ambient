import 'package:ambient/domain/models/config_model.dart';
import 'package:ambient/domain/models/howtoprepared_model.dart';
import 'package:ambient/domain/models/recomendations_model.dart';
import 'package:ambient/domain/models/recycler_model.dart';
import 'package:ambient/domain/models/stocks_model.dart';
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

  Future<List<StockModel>> getStocks() async {
    try {
      final collectionAll = await _firestore.collection("Stocks").get();
      List<StockModel> stocksList = collectionAll.docs
          .map((e) => StockModel.fromFirebase(e.data()))
          .toList();
      return stocksList;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ConfigModel>> getConfig() async {
    try {
      final collectionAll = await _firestore.collection("Config").get();
      List<ConfigModel> configModel = collectionAll.docs
          .map((e) => ConfigModel.fromFirebase(e.data()))
          .toList();
      return configModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<HowToPreparedModel>> getHowToPrepared() async {
    try {
      final collectionAll = await _firestore.collection("howtoprepared").get();
      List<HowToPreparedModel> howToPreparedModel = collectionAll.docs
          .map((e) => HowToPreparedModel.fromFirebase(e.data()))
          .toList();
      return howToPreparedModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<HowToPreparedModel>> getHowToPreparedType(String type) async {
    try {
      final collectionAll = await _firestore
          .collection("howtoprepared")
          .where("type", isEqualTo: type)
          .get();
      List<HowToPreparedModel> howToPreparedModel = collectionAll.docs
          .map((e) => HowToPreparedModel.fromFirebase(e.data()))
          .toList();
      return howToPreparedModel;
    } catch (e) {
      throw Exception(e);
    }
  }
}
