import 'package:i_tortani_v_2_0/Utils/DB/DBHelper.dart';
import 'package:i_tortani_v_2_0/Utils/Models/SpeseOrder.dart';

class SpeseDbUser {
  static final String table_name = 'SPESE';

  static void deleteAllSpese() async {
    try {
      var db = await DBHelper.instance.db;

      db.rawDelete("""delete from $table_name""");
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<SpeseOrder>> getAllSpese() async {
    try {
      List<SpeseOrder> listaRes = [];

      var db = await DBHelper.instance.db;

      var result =
          await db.rawQuery("""select * from $table_name order by ritirato""");
      result.forEach((element) {
        listaRes.add(SpeseOrder.FromJson(element));
      });
      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<bool> insertSpese(SpeseOrder spesa) async {
    try {
      var db = await DBHelper.instance.db;

      var jsonToInsert = {
        "cliente": spesa.cliente,
        "descrizione": spesa.descrizione,
        "cell_num": spesa.cell_num,
        "data_ritiro": spesa.data_ritiro.toString(),
        "luogo": spesa.luogo,
        "check_tortani": spesa.check_tortani ? 1 : 0,
        "ritirato": spesa.ritirato == null ? "" : spesa.ritirato.toString(),
      };

      db.insert(table_name, jsonToInsert);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateSpesa(SpeseOrder spesa, String oldCliente) async {
    try {
      var db = await DBHelper.instance.db;

      if (spesa.id != 0){
        db.update(table_name, spesa.toJson(), where: 'id = ?', whereArgs: [spesa.id]);
      }else{
        db.update(table_name, spesa.toJson(),
            where: 'cliente = ?', whereArgs: [oldCliente]);
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> deleteSpesa(SpeseOrder spesa) async {
    try {
      var db = await DBHelper.instance.db;

      db.delete(table_name, where: 'cliente = ?', whereArgs: [spesa.cliente]);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static updateSpesaRitiro(SpeseOrder spesa) async {
    try {
      var db = await DBHelper.instance.db;
      spesa.ritirato = DateTime.now();

      await db.update(table_name, spesa.toJson(),
          where: 'cliente = ?', whereArgs: [spesa.cliente]);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static searchOrder(String nomeCliente) async {
    try {
      List<SpeseOrder> listaRes = [];

      nomeCliente = '%' + nomeCliente + '%';

      var db = await DBHelper.instance.db;

      var listaTmp = await db.rawQuery(
          """select * from $table_name where cliente LIKE ? order by ritirato""",
          [nomeCliente]);

      listaTmp.forEach((spesa) {
        listaRes.add(SpeseOrder.FromJson(spesa));
      });

      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
