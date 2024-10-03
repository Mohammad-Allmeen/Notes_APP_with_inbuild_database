//we create class to create multiple instances for separate objects
/*
Multiple methods , attributes and instances are created in class, but for
Database multiple instances cannot be created because there is only one database from where
we fetch, update, retrieve or delete the data

- Hence the database class is made singleton class, only one static object is created for singleton
 */

//offline data are stored in cache management,
// the data that comes from online and store in the mobile are present in cache memory
// when we download an app its of for ex 100MB but after sometimes it becomes 150MB
// ex when to go to info of any app in android the clear cache memory
// will clean all the offline data stored and will restart the app like a fresh app
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper
//dbms class is singleton class because while using database the database is only one from where we fetch, create updata or del data
    {
      DBHelper._();  //_ underscore means privatization cannot be accessed outside the class

static final DBHelper getInstance =  // static are those member who are allocated memory at compile time
  DBHelper._();
// static final so that from multiple locations it can accessed with singleton object
static final String TABLE_NOTE = "note";
static final String COLUMN_NOTE_SNO="s_no";
static final String COLUMN_NOTE_TITLE = "title";
static final String COLUMN_NOTE_DESC= 'desc';

//only once we will open the database, and suppose 10 times we are using that database so we have assigned in the variable myDB
  Database?  myDB; //database object, ? means nullable type means it can be store nul value

Future<Database> getDB() async{
  // if (myDB!=null) {
  //   return myDB!; // if myDB means if database is present or open, ! to ensure that it is not NULL
  // }
  // else
  //   {
  //     myDB = await openDB();
  //   return myDB!;
  //   }
  //alternative of above function
  myDB = myDB ?? await openDB(); //??- means if then, if myDB is not null then it will be assign in myDB otherwise it will be created when opening DB
return myDB!;
}

Future <Database> openDB () async{

  //we cannot delay on main thread that UI otherwise if it takes times to fetch the UI will get blocked

  //to create database two things are used
// path provider- used to get the directories of app
// path package - to perform the operation
Directory appDir= await getApplicationDocumentsDirectory();

String dbPath = join(appDir.path, "noteDB.db"); //.path is the function to find the path and the path is store in the dbPath variable

return await openDatabase(dbPath, onCreate: (db, version)
// openDatabase is the function in the package sqflite , onCreate is used to create the Database because
// when first time the openDatabase will function will go on that path it not find any database hence we will create it
{
  //create all your tables here
  db.execute('create table $TABLE_NOTE($COLUMN_NOTE_SNO integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text)');

 // version is used like whenever our table or schema of database is changed like a row is added colomn is added or deleted version value will be incremented
}, version: 1);
}
//queries
//insertion
Future<bool> addNote({required String mTitle, required String mDesc})  async {
var db = await getDB();
int rowsEffected = await db.insert(TABLE_NOTE,
    {
      //in table the whole is stored in List format and one particular column is stored in Map format that is key : value pair
      COLUMN_NOTE_TITLE: mTitle,
      COLUMN_NOTE_DESC: mDesc,
      //serial number is not added because it is auto incremented
    }
);
return rowsEffected>0;
}

Future<List<Map<String , dynamic>>> getAllNotes() async{
  var db = await getDB();
  // Select * from note
  List<Map<String, dynamic>> mData =await db.query(TABLE_NOTE); //to fetch all data from TABLE_NOTE and so all thr data are store in list
 // and we want to fetch only column title then we have to give condition , columns: [COLUMN_NOTE_TITLE]

return mData; // all data means whole table note will be returned
}

// Update data function
// we cannot use boolean because the function asynchronous hence it will return in future
Future<bool> updateNote({required String mTitle,required String mDesc, required int sno}) async{
  var db = await getDB();

 int rowsEffected= await db.update(TABLE_NOTE, {
    COLUMN_NOTE_TITLE: mTitle,
    COLUMN_NOTE_DESC: mDesc,
  }, where: '$COLUMN_NOTE_SNO= $sno'
  );
return rowsEffected>0;
}

    Future <bool>  deleteNote({required int sno})
   async {
      var db = await getDB();

    int rowsEffected =  await db.delete(TABLE_NOTE, where : '$COLUMN_NOTE_SNO=?', whereArgs: ['$sno']);
return rowsEffected>0;
}
    }