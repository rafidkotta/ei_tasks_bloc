import 'package:ei_taks/features/tasks/model/task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  DatabaseHelper._init(){
    load();
  }

  load() async {
    await db;
  }

  static final DatabaseHelper _instance = DatabaseHelper._init();

  static DatabaseHelper get instance => _instance;

  Database? _db;

  Future<Database> get db async{
    if(_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tasks.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.rawQuery("CREATE TABLE IF NOT EXISTS tasks(id VARCHAR(20) PRIMARY KEY, title VARCHAR(200) NOT NULL,description VARCHAR(500), assigned_to VARCHAR(50) NOT NULL)");
  }

  Future<int> deleteTask(Task task) async {
    var dbClient = await db;
    return await dbClient.delete('tasks',where: "id = ?",whereArgs: [task.id]);
  }

  Future<void> clearTasks() async {
    var dbClient = await db;
    await dbClient.rawQuery("DELETE FROM tasks");
  }

  Future<List<Task>> listTasks() async {
    List<Task> tasks = [];
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM tasks');
    for(Map task in list){
      tasks.add(Task(id: task['id'],title: task['title'],description: task['description'],assignedTo: task['assigned_to']));
    }
    return tasks;
  }

  Future<int> addTask(Task task) async {
    var dbClient = await db;
    Map<String,String> values = {};
    values.putIfAbsent('id', () => task.id);
    values.putIfAbsent('title', () => task.title);
    values.putIfAbsent('description', () => task.description);
    values.putIfAbsent('assigned_to', () => task.assignedTo);
    return await dbClient.insert('tasks', values);
  }
}