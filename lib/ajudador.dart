import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'contato.dart';

class DBHelper {
  static Future<Database> inicializarDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'contatos.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    final sql = '''CREATE TABLE contatos(
      id INTEGER PRIMARY KEY,
      nome TEXT,
      contato TEXT
    )''';

    await db.execute(sql);
  }

  static Future<int> criarContato(Contato contato) async {
    Database db = await DBHelper.inicializarDB();
    return await db.insert('contatos', contato.toJson());
  }

  static Future<List<Contato>> lerContatos() async {
    Database db = await DBHelper.inicializarDB();
    var contatos = await db.query('contatos', orderBy: 'nome');
    List<Contato> listaContatos = contatos.isNotEmpty
        ? contatos.map((detalhes) => Contato.fromJson(detalhes)).toList()
        : [];
    return listaContatos;
  }

  static Future<int> atualizarContato(Contato contato) async {
    Database db = await DBHelper.inicializarDB();
    return await db.update('contatos', contato.toJson(),
        where: 'id = ?', whereArgs: [contato.id]);
  }

  static Future<int> excluirContato(int id) async {
    Database db = await DBHelper.inicializarDB();
    return await db.delete('contatos', where: 'id = ?', whereArgs: [id]);
  }
}
