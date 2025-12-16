import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// SQLite Database Service
/// Manages database operations for users, tasks, and pickup requests
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  // Table names
  static const String tableUsers = 'users';
  static const String tableTasks = 'tasks';
  static const String tablePickupRequests = 'pickup_requests';

  // Users table columns
  static const String columnUserId = 'id';
  static const String columnUserEmail = 'email';
  static const String columnUserName = 'name';
  static const String columnUserPhone = 'phone';
  static const String columnUserRole = 'role';
  static const String columnUserPassword = 'password';
  static const String columnUserCreatedAt = 'created_at';
  static const String columnUserUpdatedAt = 'updated_at';

  // Tasks table columns
  static const String columnTaskId = 'id';
  static const String columnTaskTitle = 'title';
  static const String columnTaskDescription = 'description';
  static const String columnTaskUserId = 'user_id';
  static const String columnTaskStatus = 'status';
  static const String columnTaskPriority = 'priority';
  static const String columnTaskDueDate = 'due_date';
  static const String columnTaskCreatedAt = 'created_at';
  static const String columnTaskUpdatedAt = 'updated_at';

  // Pickup Requests table columns
  static const String columnPickupId = 'id';
  static const String columnPickupUserId = 'user_id';
  static const String columnPickupLocation = 'location';
  static const String columnPickupLatitude = 'latitude';
  static const String columnPickupLongitude = 'longitude';
  static const String columnPickupDescription = 'description';
  static const String columnPickupStatus = 'status';
  static const String columnPickupScheduledDate = 'scheduled_date';
  static const String columnPickupAssignedTo = 'assigned_to';
  static const String columnPickupCreatedAt = 'created_at';
  static const String columnPickupUpdatedAt = 'updated_at';

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  /// Get database instance
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initializeDatabase();
    return _database!;
  }

  /// Initialize database and create tables
  Future<Database> _initializeDatabase() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, 'clean_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  /// Create all required tables
  Future<void> _createTables(Database db, int version) async {
    // Create Users table
    await db.execute('''
      CREATE TABLE $tableUsers (
        $columnUserId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnUserEmail TEXT UNIQUE NOT NULL,
        $columnUserName TEXT NOT NULL,
        $columnUserPhone TEXT,
        $columnUserRole TEXT NOT NULL DEFAULT 'user',
        $columnUserPassword TEXT NOT NULL,
        $columnUserCreatedAt TEXT NOT NULL,
        $columnUserUpdatedAt TEXT NOT NULL
      )
    ''');

    // Create Tasks table
    await db.execute('''
      CREATE TABLE $tableTasks (
        $columnTaskId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTaskTitle TEXT NOT NULL,
        $columnTaskDescription TEXT,
        $columnTaskUserId INTEGER NOT NULL,
        $columnTaskStatus TEXT NOT NULL DEFAULT 'pending',
        $columnTaskPriority TEXT NOT NULL DEFAULT 'medium',
        $columnTaskDueDate TEXT,
        $columnTaskCreatedAt TEXT NOT NULL,
        $columnTaskUpdatedAt TEXT NOT NULL,
        FOREIGN KEY ($columnTaskUserId) REFERENCES $tableUsers ($columnUserId) ON DELETE CASCADE
      )
    ''');

    // Create Pickup Requests table
    await db.execute('''
      CREATE TABLE $tablePickupRequests (
        $columnPickupId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnPickupUserId INTEGER NOT NULL,
        $columnPickupLocation TEXT NOT NULL,
        $columnPickupLatitude REAL,
        $columnPickupLongitude REAL,
        $columnPickupDescription TEXT,
        $columnPickupStatus TEXT NOT NULL DEFAULT 'pending',
        $columnPickupScheduledDate TEXT,
        $columnPickupAssignedTo INTEGER,
        $columnPickupCreatedAt TEXT NOT NULL,
        $columnPickupUpdatedAt TEXT NOT NULL,
        FOREIGN KEY ($columnPickupUserId) REFERENCES $tableUsers ($columnUserId) ON DELETE CASCADE,
        FOREIGN KEY ($columnPickupAssignedTo) REFERENCES $tableUsers ($columnUserId) ON DELETE SET NULL
      )
    ''');

    // Create indexes for better query performance
    await db.execute('CREATE INDEX idx_tasks_user_id ON $tableTasks ($columnTaskUserId)');
    await db.execute('CREATE INDEX idx_tasks_status ON $tableTasks ($columnTaskStatus)');
    await db.execute('CREATE INDEX idx_pickup_user_id ON $tablePickupRequests ($columnPickupUserId)');
    await db.execute('CREATE INDEX idx_pickup_status ON $tablePickupRequests ($columnPickupStatus)');
    await db.execute('CREATE INDEX idx_pickup_assigned_to ON $tablePickupRequests ($columnPickupAssignedTo)');
  }

  // ==================== USER OPERATIONS ====================

  /// Insert a new user
  Future<int> insertUser({
    required String email,
    required String name,
    required String password,
    String? phone,
    String role = 'user',
  }) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();

    return await db.insert(
      tableUsers,
      {
        columnUserEmail: email,
        columnUserName: name,
        columnUserPassword: password,
        columnUserPhone: phone,
        columnUserRole: role,
        columnUserCreatedAt: now,
        columnUserUpdatedAt: now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get user by ID
  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await database;
    final result = await db.query(
      tableUsers,
      where: '$columnUserId = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  /// Get user by email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      tableUsers,
      where: '$columnUserEmail = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  /// Get all users
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query(tableUsers, orderBy: '$columnUserCreatedAt DESC');
  }

  /// Update user
  Future<int> updateUser({
    required int id,
    String? name,
    String? phone,
    String? role,
  }) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();

    final updates = <String, dynamic>{
      columnUserUpdatedAt: now,
    };

    if (name != null) updates[columnUserName] = name;
    if (phone != null) updates[columnUserPhone] = phone;
    if (role != null) updates[columnUserRole] = role;

    return await db.update(
      tableUsers,
      updates,
      where: '$columnUserId = ?',
      whereArgs: [id],
    );
  }

  /// Delete user
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      tableUsers,
      where: '$columnUserId = ?',
      whereArgs: [id],
    );
  }

  // ==================== TASK OPERATIONS ====================

  /// Insert a new task
  Future<int> insertTask({
    required String title,
    required int userId,
    String? description,
    String status = 'pending',
    String priority = 'medium',
    String? dueDate,
  }) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();

    return await db.insert(
      tableTasks,
      {
        columnTaskTitle: title,
        columnTaskDescription: description,
        columnTaskUserId: userId,
        columnTaskStatus: status,
        columnTaskPriority: priority,
        columnTaskDueDate: dueDate,
        columnTaskCreatedAt: now,
        columnTaskUpdatedAt: now,
      },
    );
  }

  /// Get task by ID
  Future<Map<String, dynamic>?> getTaskById(int id) async {
    final db = await database;
    final result = await db.query(
      tableTasks,
      where: '$columnTaskId = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  /// Get all tasks for a user
  Future<List<Map<String, dynamic>>> getTasksByUserId(int userId) async {
    final db = await database;
    return await db.query(
      tableTasks,
      where: '$columnTaskUserId = ?',
      whereArgs: [userId],
      orderBy: '$columnTaskDueDate ASC, $columnTaskPriority DESC',
    );
  }

  /// Get all tasks with specific status
  Future<List<Map<String, dynamic>>> getTasksByStatus(String status) async {
    final db = await database;
    return await db.query(
      tableTasks,
      where: '$columnTaskStatus = ?',
      whereArgs: [status],
      orderBy: '$columnTaskDueDate ASC',
    );
  }

  /// Get all tasks for a user with specific status
  Future<List<Map<String, dynamic>>> getTasksByUserIdAndStatus(
    int userId,
    String status,
  ) async {
    final db = await database;
    return await db.query(
      tableTasks,
      where: '$columnTaskUserId = ? AND $columnTaskStatus = ?',
      whereArgs: [userId, status],
      orderBy: '$columnTaskDueDate ASC',
    );
  }

  /// Get all tasks
  Future<List<Map<String, dynamic>>> getAllTasks() async {
    final db = await database;
    return await db.query(tableTasks, orderBy: '$columnTaskCreatedAt DESC');
  }

  /// Update task
  Future<int> updateTask({
    required int id,
    String? title,
    String? description,
    String? status,
    String? priority,
    String? dueDate,
  }) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();

    final updates = <String, dynamic>{
      columnTaskUpdatedAt: now,
    };

    if (title != null) updates[columnTaskTitle] = title;
    if (description != null) updates[columnTaskDescription] = description;
    if (status != null) updates[columnTaskStatus] = status;
    if (priority != null) updates[columnTaskPriority] = priority;
    if (dueDate != null) updates[columnTaskDueDate] = dueDate;

    return await db.update(
      tableTasks,
      updates,
      where: '$columnTaskId = ?',
      whereArgs: [id],
    );
  }

  /// Delete task
  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      tableTasks,
      where: '$columnTaskId = ?',
      whereArgs: [id],
    );
  }

  // ==================== PICKUP REQUEST OPERATIONS ====================

  /// Insert a new pickup request
  Future<int> insertPickupRequest({
    required int userId,
    required String location,
    required String description,
    double? latitude,
    double? longitude,
    String status = 'pending',
    String? scheduledDate,
    int? assignedTo,
  }) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();

    return await db.insert(
      tablePickupRequests,
      {
        columnPickupUserId: userId,
        columnPickupLocation: location,
        columnPickupDescription: description,
        columnPickupLatitude: latitude,
        columnPickupLongitude: longitude,
        columnPickupStatus: status,
        columnPickupScheduledDate: scheduledDate,
        columnPickupAssignedTo: assignedTo,
        columnPickupCreatedAt: now,
        columnPickupUpdatedAt: now,
      },
    );
  }

  /// Get pickup request by ID
  Future<Map<String, dynamic>?> getPickupRequestById(int id) async {
    final db = await database;
    final result = await db.query(
      tablePickupRequests,
      where: '$columnPickupId = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  /// Get all pickup requests for a user
  Future<List<Map<String, dynamic>>> getPickupRequestsByUserId(int userId) async {
    final db = await database;
    return await db.query(
      tablePickupRequests,
      where: '$columnPickupUserId = ?',
      whereArgs: [userId],
      orderBy: '$columnPickupScheduledDate ASC, $columnPickupCreatedAt DESC',
    );
  }

  /// Get all pickup requests with specific status
  Future<List<Map<String, dynamic>>> getPickupRequestsByStatus(String status) async {
    final db = await database;
    return await db.query(
      tablePickupRequests,
      where: '$columnPickupStatus = ?',
      whereArgs: [status],
      orderBy: '$columnPickupScheduledDate ASC',
    );
  }

  /// Get all pickup requests assigned to a user
  Future<List<Map<String, dynamic>>> getPickupRequestsAssignedTo(int userId) async {
    final db = await database;
    return await db.query(
      tablePickupRequests,
      where: '$columnPickupAssignedTo = ?',
      whereArgs: [userId],
      orderBy: '$columnPickupScheduledDate ASC',
    );
  }

  /// Get all pickup requests with specific status assigned to a user
  Future<List<Map<String, dynamic>>> getPickupRequestsByStatusAndAssignee(
    String status,
    int assigneeId,
  ) async {
    final db = await database;
    return await db.query(
      tablePickupRequests,
      where: '$columnPickupStatus = ? AND $columnPickupAssignedTo = ?',
      whereArgs: [status, assigneeId],
      orderBy: '$columnPickupScheduledDate ASC',
    );
  }

  /// Get all pickup requests
  Future<List<Map<String, dynamic>>> getAllPickupRequests() async {
    final db = await database;
    return await db.query(
      tablePickupRequests,
      orderBy: '$columnPickupCreatedAt DESC',
    );
  }

  /// Update pickup request
  Future<int> updatePickupRequest({
    required int id,
    String? location,
    String? description,
    double? latitude,
    double? longitude,
    String? status,
    String? scheduledDate,
    int? assignedTo,
  }) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();

    final updates = <String, dynamic>{
      columnPickupUpdatedAt: now,
    };

    if (location != null) updates[columnPickupLocation] = location;
    if (description != null) updates[columnPickupDescription] = description;
    if (latitude != null) updates[columnPickupLatitude] = latitude;
    if (longitude != null) updates[columnPickupLongitude] = longitude;
    if (status != null) updates[columnPickupStatus] = status;
    if (scheduledDate != null) updates[columnPickupScheduledDate] = scheduledDate;
    if (assignedTo != null) updates[columnPickupAssignedTo] = assignedTo;

    return await db.update(
      tablePickupRequests,
      updates,
      where: '$columnPickupId = ?',
      whereArgs: [id],
    );
  }

  /// Delete pickup request
  Future<int> deletePickupRequest(int id) async {
    final db = await database;
    return await db.delete(
      tablePickupRequests,
      where: '$columnPickupId = ?',
      whereArgs: [id],
    );
  }

  // ==================== UTILITY OPERATIONS ====================

  /// Get database statistics
  Future<Map<String, int>> getDatabaseStats() async {
    final db = await database;

    final userCount = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $tableUsers'),
    ) ?? 0;

    final taskCount = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $tableTasks'),
    ) ?? 0;

    final pickupCount = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $tablePickupRequests'),
    ) ?? 0;

    return {
      'users': userCount,
      'tasks': taskCount,
      'pickupRequests': pickupCount,
    };
  }

  /// Close database
  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  /// Clear all data from database
  Future<void> clearAllData() async {
    final db = await database;
    await db.delete(tableTasks);
    await db.delete(tablePickupRequests);
    await db.delete(tableUsers);
  }
}
