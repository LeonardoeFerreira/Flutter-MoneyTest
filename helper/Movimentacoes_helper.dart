import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Constants for table and column names
final String movimentacaoTABLE = "movimentacaoTABLE";
final String idColumn = "idColumn";
final String dataColumn = "dataColumn";
final String valorColumn = "valorColumn";
final String tipoColumn = "tipoColumn";
final String descricaoColumn = "descricaoColumn";

class MovimentacoesHelper {
  static final MovimentacoesHelper _instance = MovimentacoesHelper.internal();

  factory MovimentacoesHelper() => _instance;

  MovimentacoesHelper.internal();

  Database _db;

  // Getter for the database instance
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  // Initialize the database
  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "movimentacao.db");

    // Open or create the database
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      // Create the movimentacaoTABLE with columns
      await db.execute(
        "CREATE TABLE $movimentacaoTABLE(" +
        "$idColumn INTEGER PRIMARY KEY," +
        "$valorColumn FLOAT," +
        "$dataColumn TEXT," +
        "$tipoColumn TEXT," +
        "$descricaoColumn TEXT)"
      );
    });
  }

  // Save a movimentacao to the database
  Future<Movimentacoes> saveMovimentacao(Movimentacoes movimentacoes) async {
    print("chamada save");
    // Get the database instance
    Database dbMovimentacoes = await db;
    // Insert the movimentacao and update its id
    movimentacoes.id = await dbMovimentacoes.insert(movimentacaoTABLE, movimentacoes.toMap());
    return movimentacoes;
  }

  // Retrieve a movimentacao from the database by its id
  Future<Movimentacoes> getMovimentacoes(int id) async {
    // Get the database instance
    Database dbMovimentacoes = await db;
    // Query the database for a movimentacao with the given id
    List<Map> maps = await dbMovimentacoes.query(
      movimentacaoTABLE,
      columns: [idColumn, valorColumn, dataColumn, tipoColumn, descricaoColumn],
      where: "$idColumn =?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      // Return the first movimentacao found
      return Movimentacoes.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Delete a movimentacao from the database
  Future<int> deleteMovimentacao(Movimentacoes movimentacoes) async {
    // Get the database instance
    Database dbMovimentacoes = await db;
    // Delete the movimentacao from the table based on its id
    return await dbMovimentacoes.delete(
      movimentacaoTABLE,
      where: "$idColumn =?",
      whereArgs: [movimentacoes.id],
    );
  }

  // Update a movimentacao in the database
  Future<int> updateMovimentacao(Movimentacoes movimentacoes) async {
    print("chamada update");
    print(movimentacoes.toString());
    // Get the database instance
    Database dbMovimentacoes = await db;
    // Update the mov
    return await dbMovimentacoes.update(
      movimentacaoTABLE,
      movimentacoes.toMap(),
      where: "$idColumn =?",
      whereArgs: [movimentacoes.id],
    );
  }

  // Retrieve all movimentacoes from the database
  Future<List> getAllMovimentacoes() async {
    // Get the database instance
    Database dbMovimentacoes = await db;
    // Query the database to retrieve all rows from the movimentacaoTABLE
    List listMap = await dbMovimentacoes.rawQuery("SELECT * FROM $movimentacaoTABLE");
    List<Movimentacoes> listMovimentacoes = List();

    for (Map m in listMap) {
      // Convert each map to a Movimentacoes object and add it to the list
      listMovimentacoes.add(Movimentacoes.fromMap(m));
    }

    return listMovimentacoes;
  }

  // Retrieve all movimentacoes from the database based on a given month
  Future<List> getAllMovimentacoesPorMes(String data) async {
    // Get the database instance
    Database dbMovimentacoes = await db;
    // Query the database to retrieve rows from the movimentacaoTABLE where the dataColumn matches the given month
    List listMap = await dbMovimentacoes.rawQuery(
      "SELECT * FROM $movimentacaoTABLE WHERE $dataColumn LIKE '%$data%'"
    );
    List<Movimentacoes> listMovimentacoes = List();

    for (Map m in listMap) {
      // Convert each map to a Movimentacoes object and add it to the list
      listMovimentacoes.add(Movimentacoes.fromMap(m));
    }

    return listMovimentacoes;
  }

  // Retrieve all movimentacoes from the database based on a given type
  Future<List> getAllMovimentacoesPorTipo(String tipo) async {
    // Get the database instance
    Database dbMovimentacoes = await db;
    // Query the database to retrieve rows from the movimentacaoTABLE where the tipoColumn matches the given type
    List listMap = await dbMovimentacoes.rawQuery(
      "SELECT * FROM $movimentacaoTABLE WHERE $tipoColumn ='$tipo' "
    );
    List<Movimentacoes> listMovimentacoes = List();

    for (Map m in listMap) {
      // Convert each map to a Movimentacoes object and add it to the list
      listMovimentacoes.add(Movimentacoes.fromMap(m));
    }

    return listMovimentacoes;
  }

  // Retrieve the number of movimentacoes in the database
  Future<int> getNumber() async {
    // Get the database instance
    Database dbMovimentacoes = await db;
    // Execute a raw query to count the number of rows in the movimentacaoTABLE
    return Sqflite.firstIntValue(await dbMovimentacoes.rawQuery(
      "SELECT COUNT(*) FROM $movimentacaoTABLE"
    ));
  }

  // Close the database connection
  Future close() async {
    // Get the database instance
    Database dbMovimentacoes = await db;
    // Close the database connection
    dbMovimentacoes.close();
  }
}

class Movimentacoes {
  int id;
  String data;
  double valor;
  String tipo;
  String descricao;

  Movimentacoes();

  // Construct a Movimentacoes object from a map
  Movimentacoes.fromMap(Map map) {
    id = map[idColumn];
    valor = map[valorColumn];
    data = map[dataColumn];
    tipo = map[tipoColumn];
     descricao = map[descricaoColumn];
    
  }
 

  Map toMap(){
    Map<String,dynamic> map ={
      valorColumn :valor,
      dataColumn : data,
      tipoColumn : tipo,
      descricaoColumn : descricao,
      
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  String toString(){
    return "Movimentaoes(id: $id, valor: $valor, data: $data, tipo: $tipo, desc: $descricao, )";
  }
}