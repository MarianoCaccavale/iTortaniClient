import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static const String DB_NAME = 'iTortaniDB.db';

  static Database? _db;

  DBHelper._init();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB(DB_NAME);
    return _db!;
  }

  Future<Database> _initDB(String dbPath) async {
    final filePath = await getDatabasesPath();
    final path = join(filePath, dbPath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDB,
    );
  }

  Future _onCreateDB(Database db, int version) async {
    /*await db.execute("""CREATE table IF NOT EXISTS ORDER_TORTANI(
                             id INTEGER PRIMARY KEY AUTOINCREMENT,
                             cliente TEXT,
                             num_half_tortani INTEGER,
                             num_tortani INTEGER,
                             num_pizze_ripiene INTEGER,
                             num_pizze_scarole INTEGER,
                             num_half_pizze_scarole INTEGER,
                             num_pizze_salsicce INTEGER,
                             num_half_pizze_salsicce INTEGER,
                             descrizione TEXT,
                             cell_num INTEGER,
                             data_ritiro TEXT,
                             ritirato TEXT
                       )""");*/

    //Creazione tabella degli ordini di rosticceria(?)
    await db.execute("""CREATE table IF NOT EXISTS ORDER_TORTANI(
                             id INTEGER PRIMARY KEY AUTOINCREMENT,
                             cliente TEXT, 
                             num_half_tortani INTEGER, 
                             num_tortani INTEGER, 
                             num_pizze_ripiene INTEGER, 
                             num_pizze_scarole INTEGER,
                             num_half_pizze_scarole INTEGER,
                             num_pizze_salsicce INTEGER,
                             num_half_pizze_salsicce INTEGER,
                             num_rustici INTEGER,
                             descrizione TEXT, 
                             cell_num INTEGER, 
                             data_ritiro TEXT, 
                             ritirato TEXT
                       )""");

    //Creazione tabella degli ordini di spesa
    await db.execute("""CREATE table IF NOT EXISTS SPESE(
                             id INTEGER PRIMARY KEY AUTOINCREMENT, 
                             cliente TEXT, 
                             cell_num INTEGER, 
                             ritirato TEXT, 
                             descrizione TEXT, 
                             luogo TEXT, 
                             check_tortani INTEGER, 
                             data_ritiro TEXT
                       )""");
  }

  Future close() async {
    final db = await instance.db;
    db.close();
  }
}
