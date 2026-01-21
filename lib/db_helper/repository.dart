import 'package:sqflite/sqflite.dart';
import 'package:user_management_app/db_helper/database_connection.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository(){
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;
  Future<Database?> get database async{
    if(_database != null){
      return _database;
    }else{
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }
  //Insert User Data
  inserData(table, data) async{
    var connection = await database;
    return await connection!.insert(table, data);
  }

  //Read User Data Records
  readData(table) async{
      var connection = await database;
      return await connection!.query(table);
  }

  //Read a single record
  readDataById(table, id) async{
    var connection = await database;
    return await connection!.query(table, where: 'id=?', whereArgs: [id]);
  }

  //Update User Data
  updateData(table, data) async{
    var connection = await database;
    return await connection!.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Delete Data
deleteDataById(table, id) async{
    var connection = await database;
    return await connection!.rawDelete("DELETE from $table WHERE id=$id");
}
}