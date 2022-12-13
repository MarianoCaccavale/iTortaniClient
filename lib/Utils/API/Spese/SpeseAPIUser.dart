import 'package:i_tortani_v_2_0/Utils/API/RestEndpoints.dart';
import 'package:i_tortani_v_2_0/Utils/Models/Entity/SpeseOrder.dart';
import 'package:i_tortani_v_2_0/Utils/NetworkUtils.dart';

class SpeseAPIUser {
  static void deleteAllSpese() async {
    try {

      await NetworkCallUtils.deleteCall(url: RestEndpoints.speseRoot);

    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<SpeseOrder>> getAllSpese() async {
    List<SpeseOrder> listaRes = [];

    try {

      dynamic spese = await NetworkCallUtils.getCall(url: RestEndpoints.speseRoot);

      for (dynamic spesa in spese){
        listaRes.add(SpeseOrder.FromJson(spesa));
      }

      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<bool> insertSpese(SpeseOrder spesa) async {
    try {

      await NetworkCallUtils.postCall(url: RestEndpoints.speseRoot, payload: spesa.toJson());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateSpesa(SpeseOrder spesa, String oldCliente) async {
    try {

      await NetworkCallUtils.putCall(url: RestEndpoints.speseRoot + spesa.id.toString(), payload: spesa.toJson());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> deleteSpesa(SpeseOrder spesa) async {
    try {

      await NetworkCallUtils.deleteCall(url: RestEndpoints.speseRoot + spesa.id.toString());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static updateSpesaRitiro(SpeseOrder spesa) async {
    try {

      await NetworkCallUtils.putCall(url: RestEndpoints.speseRoot + spesa.id.toString(), payload: spesa.toJson());

    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static searchOrder(String nomeCliente) async {
    List<SpeseOrder> listaRes = [];

    try {

      dynamic spese = await NetworkCallUtils.getCall(url: RestEndpoints.speseSearch + nomeCliente);

      for (dynamic spesa in spese){
        listaRes.add(SpeseOrder.FromJson(spesa));
      }

      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
