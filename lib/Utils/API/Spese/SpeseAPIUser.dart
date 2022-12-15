import 'dart:convert';

import 'package:i_tortani_v_2_0/Utils/API/RestEndpoints.dart';
import 'package:i_tortani_v_2_0/Utils/Models/DTO/SpeseOrderDTO.dart';
import 'package:i_tortani_v_2_0/Utils/Models/Entity/SpeseOrder.dart';
import 'package:i_tortani_v_2_0/Utils/NetworkUtils.dart';

import '../../Constants.dart';

class SpeseAPIUser {
  static void deleteAllSpese() async {
    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
    };

    try {
      await NetworkCallUtils.postCall(
          url: RestEndpoints.speseDeleteAll, payload: jsonEncode(payload));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<SpeseOrder>> getAllSpese() async {

    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
    };

    List<SpeseOrder> listaRes = [];

    SpeseOrderDTO dto;
    SpeseOrder elem;

    try {
      dynamic spese = await NetworkCallUtils.postCall(
          url: RestEndpoints.speseGetAllSpese, payload: jsonEncode(payload));

      for (dynamic spesa in spese) {

        dto = SpeseOrderDTO.FromJson(spesa);

        elem = SpeseOrder(
            dto.id,
            dto.cliente,
            dto.cell_num,
            dto.descrizione,
            dto.luogo,
            dto.check_tortani,
            dto.data_ritiro
        );

        listaRes.add(elem);
      }

      listaRes.sort((spesa1, spesa2){
        if( spesa1.ritirato == null){
          return -1;
        }else if (spesa2.ritirato == null){
          return 1;
        }else{
          return spesa1.ritirato!.compareTo(spesa2.ritirato!);
        }
      });

      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<bool> insertSpese(SpeseOrder spesa) async {
    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
    };

    try {
      SpeseOrderDTO dto = SpeseOrderDTO(
          spesa.id,
          spesa.cliente,
          spesa.cell_num,
          spesa.descrizione,
          spesa.luogo,
          spesa.check_tortani,
          spesa.data_ritiro);

      payload['spesa'] = dto.toJson();

      payload['spesa'] = await NetworkCallUtils.postCall(
          url: RestEndpoints.speseInsertOrder, payload: jsonEncode(payload));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateSpesa(SpeseOrder spesa, String oldCliente) async {

    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
    };
    
    try {

      SpeseOrderDTO dto = SpeseOrderDTO(
          spesa.id,
          spesa.cliente,
          spesa.cell_num,
          spesa.descrizione,
          spesa.luogo,
          spesa.check_tortani,
          spesa.data_ritiro);

      payload['spesa'] = dto.toJson();
      
      await NetworkCallUtils.postCall(
          url: RestEndpoints.speseUpdateOrdine, payload: jsonEncode(payload));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> deleteSpesa(SpeseOrder spesa) async {
    
    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
      'id': spesa.id,
    };
    
    try {
      await NetworkCallUtils.postCall(url: RestEndpoints.speseDeleteOrdine, payload: jsonEncode(payload));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static updateSpesaRitiro(SpeseOrder spesa) async {

    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
    };
    
    try {

      SpeseOrderDTO dto = SpeseOrderDTO(
          spesa.id,
          spesa.cliente,
          spesa.cell_num,
          spesa.descrizione,
          spesa.luogo,
          spesa.check_tortani,
          spesa.data_ritiro);

      payload['spesa'] = dto.toJson();
      
      await NetworkCallUtils.postCall(
          url: RestEndpoints.speseUpdateOrderRitirato, payload: jsonEncode(payload));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static searchOrder(String nomeCliente) async {

    Map<String, dynamic> payload = {
      'accessToken': Constants.accessToken,
      'nomeCliente': nomeCliente,
    };

    List<SpeseOrder> listaRes = [];

    try {
      dynamic spese =
          await NetworkCallUtils.postCall(url: RestEndpoints.speseSearchOrder, payload: jsonEncode(payload));

      for (dynamic spesa in spese) {
        listaRes.add(SpeseOrder.FromJson(spesa));
      }

      listaRes.sort((order1, order2){
        if( order1.ritirato == null){
          return -1;
        }else if (order2.ritirato == null){
          return 1;
        }else{
          return order1.ritirato!.compareTo(order2.ritirato!);
        }
      });

      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
