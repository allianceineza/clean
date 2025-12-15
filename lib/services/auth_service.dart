// User Role Enum
enum UserRole { user, admin }

// Simple Auth Service to manage user state
class AuthService {
  static UserRole? currentUserRole;
  static String? currentUserEmail;
  static bool isLoggedIn = false;

  static void login(String email, UserRole role) {
    currentUserEmail = email;
    currentUserRole = role;
    isLoggedIn = true;
  }

  static void logout() {
    currentUserEmail = null;
    currentUserRole = null;
    isLoggedIn = false;
  }

  static bool isAdmin() {
    return currentUserRole == UserRole.admin;
  }

  static bool isUser() {
    return currentUserRole == UserRole.user;
  }
}