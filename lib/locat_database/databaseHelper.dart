import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../CRM_Directory/CRM_Models/AccountMaster_model/Account_Draft_model.dart';
import '../models/location/LocationData.dart';
class DatabaseHelper {
  Database? _database;
  //static const _databaseName = "LOCATION.db";
  static const _databaseName = "ServiceManagement.db";
  static const _databaseVersion = 2;
  static const table = 'LOCATION_TABLE';
  //static const initScript = []; // Initialization script split into seperate statements
  //static const migrationScripts = [];

  //todo crm database initlize....

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }



  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/ServiceManagement.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }



  //TODO  this opens the database (and creates it if it doesn't exist)......
  Future<Database?> initializeDatabase() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), _databaseName),
        version: _databaseVersion,
        onCreate: (db, version) {
          //initScript.forEach((script) async => await db.execute(script));//todo for migration new data if change table
          // Create your table
          db.execute('''
            CREATE TABLE $table(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            latitude REAL,
            longitude REAL,
            area TEXT,
            locality TEXT,
            postal_code TEXT,
            country TEXT,
            battery_level TEXT,
            device_id TEXT
            )
          ''');

        },

      );
    }
    return _database; // Return the initialized database
  }


  //TODO insert data in table
  Future<int> insertLocationData(LocationData data) async {
    final db = await initializeDatabase(); // Initialize the database
    int result= await db!.insert(table, data.toJson() );
    return result;
  }

  // TODO: Fetch all location data from the table
  Future<List<LocationData>> getAllLocationData() async {
    try {
      final db = await initializeDatabase();
      final List<Map<String, dynamic>> maps = await db!.query(table);

      // TODO Convert the List<Map> to a List<LocationData>
      return List.generate(maps.length, (i) {
        return LocationData(
            latitude: maps[i]['latitude'],
            longitude: maps[i]['longitude'],
            area: maps[i]['area'],
            locality: maps[i]['locality'],
            postal_code: maps[i]['postal_code'],
            country: maps[i]['country'],
            battery_level: maps[i]['battery_level'],
            device_id: maps[i]['device_id']
        );
      });
    }catch(e){
      return[];
    }
  }


  // TODO: Delete all data from the table
  Future<int> deleteAllLocationData() async {
    final db = await initializeDatabase();
    int result =await db!.delete(table);
    return result;
  }



  Future<void> insertItem(AccountDraftModel item) async {
    final db = await database;
    await db.insert(
      'Account_DataBase',
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<AccountDraftModel>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Account_DataBase');
    return List.generate(maps.length, (i) {
      return AccountDraftModel.fromJson(maps[i]);
    });
  }

  Future<void> updateItem(AccountDraftModel item) async {
    final db = await database;
    await db.update(
      'Account_DataBase',
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete(
      'Account_DataBase',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllItems() async {
    final db = await database; // Open or get reference to the database

    try {
      await db.delete(
        'Account_DataBase',
      );
    } catch (e) {
      print('Failed to delete all data: $e');
    }
  }

  Future<void> dropTable() async {
    final db = await database; // Open or get reference to the database

    try {
      await db.execute('DROP TABLE IF EXISTS Account_DataBase');
      print('Table Account_DataBase deleted successfully.');
    } catch (e) {
      print('Failed to delete table: $e');
    }
  }

  Future close() async {
    final db = await database;
    db.close();
  }


  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Account_DataBase (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      account_code TEXT,
      account_name TEXT NOT NULL,
      account_owner TEXT,
      account_title TEXT,
      account_type TEXT,
      referral_by TEXT,
      phone_no TEXT,
      email_id TEXT,
      account_category_type TEXT,
      company_profile_type TEXT,
      company_profile_sub_type TEXT,
      company_profile_remark TEXT,
      no_of_employees INTEGER,
      annual_revenue REAL,
      tat_response_type TEXT,
      tat_response_time INTEGER,
      sales_representative TEXT,
      regional_service_head TEXT,
      profile TEXT,
      is_active INTEGER,
      created_by TEXT,
      created_on TEXT,
      updated_by TEXT,
      updated_on TEXT,
      is_manager INTEGER,
      gst_type TEXT,
      gst_no TEXT,
      pan_no TEXT,
      ifsc_code TEXT,
      address TEXT,
      address2 TEXT,
      post_code TEXT,
      state_code TEXT,
      state_name TEXT,
      country_code TEXT,
      country_name TEXT,
      city TEXT,
      district TEXT,
      shipping_address TEXT,
      shipping_address2 TEXT,
      shipping_post_code TEXT,
      shipping_state_code TEXT,
      shipping_city TEXT,
      shipping_district TEXT
    )
  ''');
  }



}