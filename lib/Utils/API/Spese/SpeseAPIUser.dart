import 'package:i_tortani_v_2_0/Utils/Models/SpeseOrder.dart';

class SpeseAPIUser {
  static void deleteAllSpese() async {
    try {} catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<SpeseOrder>> getAllSpese() async {
    List<SpeseOrder> listaRes = [];

    try {
      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<bool> insertSpese(SpeseOrder spesa) async {
    try {
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateSpesa(SpeseOrder spesa, String oldCliente) async {
    try {
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> deleteSpesa(SpeseOrder spesa) async {
    try {
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static updateSpesaRitiro(SpeseOrder spesa) async {
    try {} catch (e) {
      print(e);
      rethrow;
    }
  }

  static searchOrder(String nomeCliente) async {
    List<SpeseOrder> listaRes = [];

    try {
      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
