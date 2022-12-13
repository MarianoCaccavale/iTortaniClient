import 'package:i_tortani_v_2_0/Utils/DB/DBHelper.dart';
import 'package:i_tortani_v_2_0/Utils/Models/Entity/TortaniOrder.dart';

class TortaniDBUser {
  static final String table_name = 'ORDER_TORTANI';

  static Future<void> deleteAllTortani() async {
    try {
      var db = await DBHelper.instance.db;

      db.rawDelete("""delete from $table_name""");
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<bool> insertOrdine(TortaniOrder order) async {
    try {
      var db = await DBHelper.instance.db;

      /*var jsonToInsert = {
        "cliente": order.cliente,
        "num_half_tortani": order.num_half_tortani,
        "num_tortani": order.num_tortani,
        "num_pizze_ripiene": order.num_pizze_ripiene,
        "num_pizze_scarole": order.num_pizze_scarole,
        "num_half_pizze_scarole": order.num_half_pizze_scarole,
        "num_pizze_salsicce": order.num_pizze_salsiccie,
        "num_half_pizze_salsicce": order.num_half_pizze_salsiccie,
        "descrizione": order.descrizione,
        "cell_num": order.cell_num,
        "data_ritiro": order.data_ritiro.toString().split(" ").first,
        "ritirato": order.ritirato == null ? '' : order.ritirato.toString(),
      };*/

      var jsonToInsert = {
        "cliente": order.cliente,
        "num_half_tortani": order.num_half_tortani,
        "num_tortani": order.num_tortani,
        "num_pizze_ripiene": order.num_pizze_ripiene,
        "num_pizze_scarole": order.num_pizze_scarole,
        "num_half_pizze_scarole": order.num_half_pizze_scarole,
        "num_pizze_salsicce": order.num_pizze_salsiccie,
        "num_half_pizze_salsicce": order.num_half_pizze_salsiccie,
        "num_rustici": order.num_rustici,
        "descrizione": order.descrizione,
        "cell_num": order.cell_num,
        //"data_ritiro": order.data_ritiro.toString().split(" ").first,
        "data_ritiro": order.data_ritiro.toString(),
        "ritirato": order.ritirato == null ? '' : order.ritirato.toString(),
      };

      await db.insert(table_name, jsonToInsert);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateOrdineRitirato(TortaniOrder ordine) async {
    try {
      var db = await DBHelper.instance.db;
      ordine.ritirato = DateTime.now();

      if (ordine.idOrdine != 0) {
        await db.update(table_name, ordine.toJson(),
            where: 'id = ?', whereArgs: [ordine.idOrdine]);
      } else {
        await db.update(table_name, ordine.toJson(),
            where: 'cliente = ?', whereArgs: [ordine.cliente]);
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateOrdine(TortaniOrder order, String oldClient) async {
    try {
      var db = await DBHelper.instance.db;

      var int = 0;

      if (order.idOrdine != 0) {
        int = await db.update(table_name, order.toJson(),
            where: 'id = ?', whereArgs: [order.idOrdine]);
      } else {
        int = await db.update(table_name, order.toJson(),
            where: 'cliente = ?', whereArgs: [oldClient]);
      }

      print(int);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> deleteOrdine(TortaniOrder order) async {
    try {
      var db = await DBHelper.instance.db;

      if (order.idOrdine != 0) {
        db.delete(table_name, where: 'id = ?', whereArgs: [order.idOrdine]);
      } else {
        db.delete(table_name, where: 'cliente = ?', whereArgs: [order.cliente]);
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<TortaniOrder>> getAllTortani() async {
    List<TortaniOrder> lista_res = [];

    try {
      var db = await DBHelper.instance.db;

      var result =
          await db.rawQuery('select * from $table_name order by ritirato');

      if (result != null && result.length != 0) {
        result.forEach((element) {
          lista_res.add(TortaniOrder.fromJson(element));
        });
      }

      return lista_res;
    } catch (e) {
      print(e);
      return lista_res;
    }
  }

  static Future<List<TortaniOrder>> getSpecificTortani(
      {String? cliente, int? cell_num, bool? ritirato}) async {
    List<TortaniOrder> lista_res = [];
    var result;

    try {
      var db = await DBHelper.instance.db;

      if (cliente == null && cell_num == null && ritirato == null) {
        lista_res = await getAllTortani();
      } else {
        if (cliente != null) {
          result = db.rawQuery(
              'select * from $table_name where cliente LIKE ?', [cliente]);
        } else if (cell_num != null) {
          result = db.rawQuery(
              'select * from $table_name where cell_num = ?', [cell_num]);
        } else if (ritirato != null) {
          //SQLite doesn't accept bool value, so we have to use an int of 0 or 1
          final int _ritirato = ritirato ? 1 : 0;

          result = db.rawQuery(
              'select * from $table_name where ritirato = ?', [_ritirato]);
        }
      }

      if (result != null && result.length != 0) {
        result.forEach((element) {
          lista_res.add(TortaniOrder.fromJson(element));
        });
      }

      return lista_res;
    } catch (e) {
      print(e);
      return lista_res;
    }
  }

  static Future<List<TortaniOrder>> searchOrder(String nomeCliente) async {
    try {
      var db = await DBHelper.instance.db;
      List<TortaniOrder> listaRes = [];

      nomeCliente = '%' + nomeCliente + '%';

      var result = await db.rawQuery(
          """select * from $table_name where cliente LIKE ?  order by ritirato""",
          [nomeCliente]);

      result.forEach((element) {
        listaRes.add(TortaniOrder.fromJson(element));
      });

      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<TortaniOrder>> getTortaniFromDate(DateTime date) async {
    try {
      var db = await DBHelper.instance.db;

      List<TortaniOrder> listaRes = [];
      //todo controlla perchè questo restituisce vuoto
      var result = await db.rawQuery(
          """select * from $table_name where data_ritiro LIKE ? order by ritirato""",
          [date.toString().split(" ").first]);

      result.forEach((element) {
        listaRes.add(TortaniOrder.fromJson(element));
      });

      return listaRes;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
