import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE card_Details(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        card_number TEXT,
        card_owner TEXT,
        card_expiration_date TEXT,
        card_payment_system TEXT,
        gen_title TEXT,
        gen_currency TEXT,
        gen_credit_limit TEXT,
        pvt_pin TEXT,
        pvt_cvc TEXT,
        login_userName TEXT,
        login_password TEXT,
        login_secret TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a card_Details
// title, description: name and description of your activity
// created_at: the time that the card_Details was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'mCardDetail.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new card_Details (journal)
  static Future<int> createItem(String card_number, String card_owner,String card_expiration_date, String card_payment_system,
      String? gen_title, String? gen_currency,String? gen_credit_limit,String? pvt_pin,String? pvt_cvc,String? login_userName,
      String? login_password,String? login_secret
      ) async {
    final db = await SQLHelper.db();
    final data ={ 'card_number':card_number,
      'card_owner': card_owner,
      'card_expiration_date':card_expiration_date ,
      'card_payment_system':card_payment_system ,
      'gen_title': gen_title ,
      'gen_currency': gen_currency,
      'gen_credit_limit': gen_credit_limit,
      'pvt_pin': pvt_pin,
      'pvt_cvc': pvt_cvc,
      'login_userName': login_userName,
      'login_password': login_password,
      'login_secret': login_secret
      };
   // final data = {'title': title, 'description': descrption};
    final id = await db.insert('card_Details', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all card_Details (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    print(db.query('card_Details', orderBy: "id"));
    return db.query('card_Details', orderBy: "id");
  }

  // Read a single card_Details by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('card_Details', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an card_Details by id
  static Future<int> updateItem(
      int id, String card_number, String card_owner,String card_expiration_date, String card_payment_system,
      String? gen_title, String? gen_currency,String? gen_credit_limit,String? pvt_pin,String? pvt_cvc,String? login_userName,
      String? login_password,String? login_secret) async {
    final db = await SQLHelper.db();

    final data = {
      'card_number':card_number,
      'card_owner': card_owner,
      'card_expiration_date':card_expiration_date ,
      'card_payment_system':card_payment_system ,
      'gen_title': gen_title ,
      'gen_currency': gen_currency,
      'gen_credit_limit': gen_credit_limit,
      'pvt_pin': pvt_pin,
      'pvt_cvc': pvt_cvc,
      'login_userName': login_userName,
      'login_password': login_password,
      'login_secret': login_secret,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('card_Details', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("card_Details", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an card Details: $err");
    }
  }
}