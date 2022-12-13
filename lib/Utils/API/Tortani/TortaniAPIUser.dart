import 'dart:convert';

import 'package:i_tortani_v_2_0/Utils/API/RestEndpoints.dart';
import 'package:i_tortani_v_2_0/Utils/Constants.dart';
import 'package:i_tortani_v_2_0/Utils/Models/DTO/TortaniOrderDTO.dart';
import 'package:i_tortani_v_2_0/Utils/Models/Entity/TortaniOrder.dart';
import 'package:i_tortani_v_2_0/Utils/NetworkUtils.dart';

class TortaniAPIUser {
  static Future<void> deleteAllTortani() async {

    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
    };

    try {
     await NetworkCallUtils.postCall(url: RestEndpoints.tortaniDeleteAll, payload: jsonEncode(payload));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<bool> insertOrdine(TortaniOrder order) async {

    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
    };

    try {

      TortaniOrderDTO dto = TortaniOrderDTO(
          order.idOrdine,
          order.cliente,
          order.num_half_tortani,
          order.num_tortani,
          order.num_pizze_ripiene,
          order.num_pizze_scarole,
          order.num_half_pizze_scarole,
          order.num_pizze_salsiccie,
          order.num_half_pizze_salsiccie,
          order.num_rustici,
          order.descrizione,
          order.data_ritiro,
          cell_num: order.cell_num,
          ritirato: order.ritirato);

      payload['order'] = dto.toJson();

      await NetworkCallUtils.postCall(
          url: RestEndpoints.tortaniInsertOrder,
          payload: jsonEncode(payload));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateOrdineRitirato(TortaniOrder order) async {

    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
    };

    try {
      TortaniOrderDTO dto = TortaniOrderDTO(
          order.idOrdine,
          order.cliente,
          order.num_half_tortani,
          order.num_tortani,
          order.num_pizze_ripiene,
          order.num_pizze_scarole,
          order.num_half_pizze_scarole,
          order.num_pizze_salsiccie,
          order.num_half_pizze_salsiccie,
          order.num_rustici,
          order.descrizione,
          order.data_ritiro,
          cell_num: order.cell_num,
          ritirato: order.ritirato);

      payload['order'] = dto.toJson();

      await NetworkCallUtils.postCall(
          url: RestEndpoints.tortaniUpdateOrderRitirato,
          payload: jsonEncode(payload));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateOrdine(TortaniOrder order, String oldClient) async {

    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
    };

    try {
      TortaniOrderDTO dto = TortaniOrderDTO(
          order.idOrdine,
          order.cliente,
          order.num_half_tortani,
          order.num_tortani,
          order.num_pizze_ripiene,
          order.num_pizze_scarole,
          order.num_half_pizze_scarole,
          order.num_pizze_salsiccie,
          order.num_half_pizze_salsiccie,
          order.num_rustici,
          order.descrizione,
          order.data_ritiro,
          cell_num: order.cell_num,
          ritirato: order.ritirato);

      payload['order'] = dto.toJson();

      await NetworkCallUtils.postCall(
          url: RestEndpoints.tortaniUpdateOrdine,
          payload: jsonEncode(payload));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> deleteOrdine(TortaniOrder order) async {

    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
    };

    try {
      await NetworkCallUtils.postCall(
          url: RestEndpoints.tortaniDeleteOrdine, payload: jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<TortaniOrder>> getAllTortani() async {

    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
    };

    List<TortaniOrder> listaRes = [];

    TortaniOrderDTO dto;
    TortaniOrder elem;

    try {
      List orders =
          await NetworkCallUtils.postCall(url: RestEndpoints.tortaniGetAllTortani, payload: jsonEncode(payload));

      for (dynamic order in orders) {

        dto = TortaniOrderDTO.fromJson(order);

        elem = TortaniOrder(
            dto.idOrdine,
            dto.cliente,
            dto.num_half_tortani,
            dto.num_tortani,
            dto.num_pizze_ripiene,
            dto.num_pizze_scarole,
            dto.num_half_pizze_scarole,
            dto.num_pizze_salsiccie,
            dto.num_half_pizze_salsiccie,
            dto.num_rustici,
            dto.descrizione,
            dto.data_ritiro,
            cell_num: dto.cell_num,
            ritirato: dto.ritirato);

        listaRes.add(elem);
      }

      return listaRes;
    } catch (e) {
      print(e);
      return listaRes;
    }
  }

  static Future<List<TortaniOrder>> searchOrder(String nomeCliente) async {

    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
    };

    List<TortaniOrder> listaRes = [];

    TortaniOrderDTO dto;
    TortaniOrder elem;

    try {
      dynamic orders = await NetworkCallUtils.postCall(
          url: RestEndpoints.tortaniSearchOrder, payload: jsonEncode(payload));

      for (dynamic order in orders) {

        dto = TortaniOrderDTO.fromJson(order);

        elem = TortaniOrder(
            dto.idOrdine,
            dto.cliente,
            dto.num_half_tortani,
            dto.num_tortani,
            dto.num_pizze_ripiene,
            dto.num_pizze_scarole,
            dto.num_half_pizze_scarole,
            dto.num_pizze_salsiccie,
            dto.num_half_pizze_salsiccie,
            dto.num_rustici,
            dto.descrizione,
            dto.data_ritiro,
            cell_num: dto.cell_num,
            ritirato: dto.ritirato);

        listaRes.add(elem);
      }

      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<TortaniOrder>> getTortaniFromDate(DateTime date) async {

    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
    };

    List<TortaniOrder> listaRes = [];

    TortaniOrderDTO dto;
    TortaniOrder elem;

    try {
      dynamic orders = await NetworkCallUtils.postCall(
          url: RestEndpoints.tortaniGetTortaniFromDate, payload: jsonEncode(payload));

      for (dynamic order in orders) {
        dto = TortaniOrderDTO.fromJson(order);

        elem = TortaniOrder(
            dto.idOrdine,
            dto.cliente,
            dto.num_half_tortani,
            dto.num_tortani,
            dto.num_pizze_ripiene,
            dto.num_pizze_scarole,
            dto.num_half_pizze_scarole,
            dto.num_pizze_salsiccie,
            dto.num_half_pizze_salsiccie,
            dto.num_rustici,
            dto.descrizione,
            dto.data_ritiro,
            cell_num: dto.cell_num,
            ritirato: dto.ritirato);

        listaRes.add(elem);
      }

      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
