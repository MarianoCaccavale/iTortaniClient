import 'dart:convert';

import 'package:i_tortani_v_2_0/Utils/API/RestEndpoints.dart';
import 'package:i_tortani_v_2_0/Utils/Models/Entity/TortaniOrder.dart';
import 'package:i_tortani_v_2_0/Utils/NetworkUtils.dart';

class TortaniAPIUser {
  static Future<void> deleteAllTortani() async {
    try {
      await NetworkCallUtils.deleteCall(url: RestEndpoints.tortaniRoot);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<bool> insertOrdine(TortaniOrder order) async {
    try {
      await NetworkCallUtils.postCall(
          url: RestEndpoints.tortaniRoot, payload: jsonEncode(
          {"order": order.toJson()}));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateOrdineRitirato(TortaniOrder order) async {
    try {
      await NetworkCallUtils.putCall(
          url: RestEndpoints.tortaniRoot + order.idOrdine.toString(),
          payload: jsonEncode({"order" : order.toJson()}));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateOrdine(TortaniOrder order, String oldClient) async {
    try {
      await NetworkCallUtils.putCall(
          url: RestEndpoints.tortaniRoot + order.idOrdine.toString(),
          payload: jsonEncode({"order" : order.toJson()}));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> deleteOrdine(TortaniOrder order) async {
    try {
      await NetworkCallUtils.deleteCall(
          url: RestEndpoints.tortaniRoot + order.idOrdine.toString());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<TortaniOrder>> getAllTortani() async {
    List<TortaniOrder> lista_res = [];

    try {
      List orders =
          await NetworkCallUtils.getCall(url: RestEndpoints.tortaniRoot);

      for (dynamic order in orders) {
        lista_res.add(TortaniOrder.fromJson(order));
      }

      return lista_res;
    } catch (e) {
      print(e);
      return lista_res;
    }
  }

  static Future<List<TortaniOrder>> getSpecificTortani(
      {String? cliente, int? cell_num, bool? ritirato}) async {
    throw UnimplementedError();
  }

  static Future<List<TortaniOrder>> searchOrder(String nomeCliente) async {
    List<TortaniOrder> listaRes = [];

    try {
      dynamic orders = await NetworkCallUtils.getCall(
          url: RestEndpoints.tortaniSearch + nomeCliente);

      for (dynamic order in orders) {
        listaRes.add(TortaniOrder.fromJson(order));
      }

      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<TortaniOrder>> getTortaniFromDate(DateTime date) async {
    List<TortaniOrder> listaRes = [];

    try {
      dynamic orders = await NetworkCallUtils.getCall(
          url: RestEndpoints.tortaniSearch + date.toString());

      for (dynamic order in orders) {
        listaRes.add(TortaniOrder.fromJson(order));
      }

      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
