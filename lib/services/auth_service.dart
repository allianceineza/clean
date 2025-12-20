import 'database_helper.dart';

// User Role Enum
enum UserRole { user, admin }

// Auth Service to manage user state with SQLite
class AuthService {
  static UserRole? currentUserRole;
  static String? currentUserEmail;
  static int? currentUserId;
  static bool isLoggedIn = false;
  static Map<String, dynamic>? currentUserData;

  // Add this getter property for currentUser
  static Map<String, dynamic>? get currentUser {
    return currentUserData;
  }

  // Sign up with email and password
  static Future<bool> signUp(
    String email,
    String password,
    String firstName,
    String lastName, {
    String? phone,
    String? location,
  }) async {
    try {
      // Check if user already exists
      final existingUser = await DatabaseService.instance.getUserByEmail(email);
      if (existingUser != null) {
        print('User already exists');
        return false;
      }

      // Create new user
      await DatabaseService.instance.createUser({
        'email': email,
        'password': password, // In production, use proper hashing like bcrypt
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone ?? '',
        'location': location ?? '',
        'role': 'user',
        'createdAt': DateTime.now().toIso8601String(),
        'id': DateTime.now().millisecondsSinceEpoch, // Temporary ID
      });

      // Auto login after signup
      currentUserId = DateTime.now().millisecondsSinceEpoch; // Temporary ID
      currentUserEmail = email;
      currentUserRole = UserRole.user;
      isLoggedIn = true;

      // Get full user data
      currentUserData = {
        'id': currentUserId,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone ?? '',
        'location': location ?? '',
        'role': 'user',
      };

      return true;
    } catch (e) {
      print('Sign up error: $e');
      return false;
    }
  }

  // Sign in with email and password
  static Future<bool> signIn(String email, String password) async {
    try {
      final user = await DatabaseService.instance.getUserByEmail(email);

      if (user != null && user['password'] == password) {
        currentUserId = user['id'] is int ? user['id'] as int : 1;
        currentUserEmail = email;
        currentUserRole =
            user['role'] == 'admin' ? UserRole.admin : UserRole.user;
        currentUserData = user;
        isLoggedIn = true;

        return true;
      }

      print('Invalid credentials');
      return false;
    } catch (e) {
      print('Sign in error: $e');
      return false;
    }
  }

  // Check for admin email
  static bool checkAdminEmail(String email) {
    return email == 'admin@cleanroute.com';
  }

  // Manual login (for development/testing or bypassing database)
  static void login(String email, UserRole role) {
    currentUserEmail = email;
    currentUserRole = role;
    isLoggedIn = true;
    currentUserId = DateTime.now().millisecondsSinceEpoch;
    currentUserData = {
      'id': currentUserId,
      'email': email,
      'firstName': 'Test',
      'lastName': 'User',
      'role': role == UserRole.admin ? 'admin' : 'user',
    };
  }

  // Logout
  static Future<void> logout() async {
    currentUserEmail = null;
    currentUserRole = null;
    currentUserId = null;
    currentUserData = null;
    isLoggedIn = false;
  }

  // Check if current user is admin
  static bool isAdmin() {
    return currentUserRole == UserRole.admin;
  }

  // Check if current user is regular user
  static bool isUser() {
    return currentUserRole == UserRole.user;
  }

  // Get current user data
  static Map<String, dynamic>? getCurrentUserData() {
    return currentUserData;
  }

  // Get current user's full name
  static String getCurrentUserName() {
    if (currentUserData != null) {
      final firstName = currentUserData!['firstName'] ?? '';
      final lastName = currentUserData!['lastName'] ?? '';
      return '$firstName $lastName'.trim();
    }
    return currentUserEmail ?? 'User';
  }

  // Update current user data
  static Future<bool> updateCurrentUser(Map<String, dynamic> updates) async {
    if (currentUserId == null) return false;

    try {
      await DatabaseService.instance.updateUser(currentUserId!.toString(), updates);

      // Refresh user data
      currentUserData = await DatabaseService.instance.getUser(currentUserId!.toString());
      if (currentUserData == null) {
        // If getUser returns null, update local data
        currentUserData = {...(currentUserData ?? {}), ...updates};
      }

      return true;
    } catch (e) {
      print('Update user error: $e');
      return false;
    }
  }

  // Change password
  static Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    if (currentUserId == null) return false;

    try {
      final user = await DatabaseService.instance.getUser(currentUserId!.toString());

      if (user != null && user['password'] == currentPassword) {
        await DatabaseService.instance.updateUser(currentUserId!.toString(), {
          'password': newPassword,
        });

        // Refresh user data
        currentUserData = await DatabaseService.instance.getUser(currentUserId!.toString());

        return true;
      }

      return false;
    } catch (e) {
      print('Change password error: $e');
      return false;
    }
  }

  // Get current user ID as string (for database operations)
  static String? getCurrentUserIdString() {
    return currentUserId?.toString();
  }

  // Check if user is logged in
  static bool get isUserLoggedIn {
    return isLoggedIn;
  }

  // Get user initials (for avatars)
  static String getUserInitials() {
    if (currentUserData != null) {
      final firstName = currentUserData!['firstName']?.toString() ?? '';
      final lastName = currentUserData!['lastName']?.toString() ?? '';
      
      if (firstName.isNotEmpty && lastName.isNotEmpty) {
        return '${firstName[0]}${lastName[0]}'.toUpperCase();
      } else if (firstName.isNotEmpty) {
        return firstName[0].toUpperCase();
      } else if (currentUserEmail != null && currentUserEmail!.isNotEmpty) {
        return currentUserEmail![0].toUpperCase();
      }
    }
    return 'U';
  }

  // Get user location
  static String getUserLocation() {
    if (currentUserData != null && currentUserData!['location'] != null) {
      return currentUserData!['location']!.toString();
    }
    return 'Unknown Location';
  }

  // Get user phone number
  static String getUserPhone() {
    if (currentUserData != null && currentUserData!['phone'] != null) {
      return currentUserData!['phone']!.toString();
    }
    return 'Not provided';
  }

  // Initialize with mock data for testing
  static void initializeWithMockData() {
    if (!isLoggedIn) {
      login('test@example.com', UserRole.user);
    }
  }

  // Initialize with admin data for testing
  static void initializeAsAdmin() {
    login('admin@cleanroute.com', UserRole.admin);
  }
}