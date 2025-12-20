// lib/database/database_helper.dart
import 'package:sqlite3/sqlite3.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static Database? _database;
  static String? _dbPath;

  static Database get database {
    if (_database == null) {
      throw Exception('Database not initialized. Call initialize() first.');
    }
    return _database!;
  }

  static Future<void> initialize() async {
    // Get application documents directory
    final appDir = await getApplicationDocumentsDirectory();
    _dbPath = path.join(appDir.path, 'clean_route.db');
    
    // Open or create database
    _database = sqlite3.open(_dbPath!);
    
    // Create tables
    _createTables();
    print('Database initialized at: $_dbPath');
  }

  static void _createTables() {
    database.execute('''
      CREATE TABLE IF NOT EXISTS recycle_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT NOT NULL UNIQUE,
        count INTEGER DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Insert default categories if they don't exist
    final categories = ['Glass', 'Metal', 'Cardboard', 'Electronics', 'Paper', 'Plastic Bottles'];
    for (final category in categories) {
      database.execute(
        'INSERT OR IGNORE INTO recycle_items (category, count) VALUES (?, 0)',
        [category]
      );
    }
  }

  static int getItemCount(String category) {
    try {
      final result = database.select(
        'SELECT count FROM recycle_items WHERE category = ?',
        [category]
      );
      
      if (result.isNotEmpty) {
        return result.first['count'] as int;
      }
      return 0;
    } catch (e) {
      print('Error getting item count for $category: $e');
      return 0;
    }
  }

  static void updateItemCount(String category, int count) {
    try {
      database.execute(
        'UPDATE recycle_items SET count = ?, updated_at = CURRENT_TIMESTAMP WHERE category = ?',
        [count, category]
      );
      print('Updated $category count to $count');
    } catch (e) {
      print('Error updating $category: $e');
    }
  }

  static int getTotalItems() {
    try {
      final result = database.select(
        'SELECT SUM(count) as total FROM recycle_items'
      );
      
      if (result.isNotEmpty && result.first['total'] != null) {
        return result.first['total'] as int;
      }
      return 0;
    } catch (e) {
      print('Error getting total items: $e');
      return 0;
    }
  }

  static Map<String, int> getAllItemCounts() {
    final Map<String, int> counts = {};
    try {
      final result = database.select(
        'SELECT category, count FROM recycle_items'
      );
      
      for (final row in result) {
        counts[row['category'] as String] = row['count'] as int;
      }
    } catch (e) {
      print('Error getting all counts: $e');
    }
    return counts;
  }

  static void resetAllCounts() {
    try {
      database.execute(
        'UPDATE recycle_items SET count = 0, updated_at = CURRENT_TIMESTAMP'
      );
      print('All counts reset to 0');
    } catch (e) {
      print('Error resetting counts: $e');
    }
  }

  static void close() {
    _database?.dispose();
    _database = null;
    print('Database closed');
  }
}

// For compatibility with your existing code
class DatabaseService {
  static final DatabaseService instance = DatabaseService._();
  DatabaseService._();
  
  // Dummy methods for other parts of your app
  Future<void> createPickupRequest(Map<String, dynamic> data) async {
    print('Pickup request created: $data');
    // You can implement this later
  }
  
  Future<List<Map<String, dynamic>>> getEvents() async {
    return [];
  }
  
  Future<List<Map<String, dynamic>>> getTips() async {
    return [];
  }
  
  Future<List<Map<String, dynamic>>> getBlogPosts() async {
    return [];
  }
  
  Future<void> registerUser(Map<String, dynamic> userData) async {
    print('User registered: $userData');
  }
  
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    return null;
  }
  
  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    print('User updated: $userId, $updates');
  }
  
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    return [];
  }
  
  Future<List<Map<String, dynamic>>> getAllPickupRequests() async {
    return [];
  }
  
  Future<void> updatePickupStatus(String requestId, String status) async {
    print('Pickup status updated: $requestId -> $status');
  }
}