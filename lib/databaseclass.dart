import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class databaseclass {
  Future<Database> fordatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cart.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE cart (ID INTEGER PRIMARY KEY, title TEXT, imageurl TEXT, pricetag TEXT )');
        });
    return database;
  }

  Future<bool> insertdata(String titlee, String image, String pricetag, Database database) async {
    // Check if the data already exists in the database
    List<Map<String, dynamic>> result = await database.query(
      'cart',
      where: 'title = ? AND imageurl = ? AND pricetag = ?',
      whereArgs: [titlee, image, pricetag],
    );

    // If the result is not empty, it means the data already exists, so you can return without inserting again
    if (result.isNotEmpty) {
      print('Data already exists in the database');
      return false;
    }

    // If the result is empty, it means the data is not present, and you can proceed with inserting
    String insertQuery =
        "INSERT INTO cart (title, imageurl, pricetag) VALUES ('$titlee', '$image', '$pricetag')";
    int rowsAffected = await database.rawInsert(insertQuery);

    if (rowsAffected > 0) {
      print('Data inserted successfully');
      return true;
    } else {
      print('Failed to insert data');
      return true;
    }
  }



  Future<List<Map>> viewdata(Database database) async {
    String select = "select * from cart";
    List<Map> listt = await database.rawQuery(select);
    return listt;
  }

  Future<void> deletdata(int idd, Database database) async {
    String delete = "Delete from cart where id='$idd'";
    int abc= await database.rawDelete(delete);
  }

}