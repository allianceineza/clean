import 'package:flutter/foundation.dart';

/// Authentication state model
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? userId;
  final String? email;
  final String? displayName;
  final String? errorMessage;
  final DateTime? lastAuthTime;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.userId,
    this.email,
    this.displayName,
    this.errorMessage,
    this.lastAuthTime,
  });

  /// Create a copy of this state with modified fields
  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? userId,
    String? email,
    String? displayName,
    String? errorMessage,
    DateTime? lastAuthTime,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      errorMessage: errorMessage ?? this.errorMessage,
      lastAuthTime: lastAuthTime ?? this.lastAuthTime,
    );
  }
}

/// Authentication Provider using ChangeNotifier pattern
class AuthProvider extends ChangeNotifier {
  AuthState _state = const AuthState();

  /// Get current authentication state
  AuthState get state => _state;

  /// Check if user is authenticated
  bool get isAuthenticated => _state.isAuthenticated;

  /// Check if loading
  bool get isLoading => _state.isLoading;

  /// Get current user ID
  String? get userId => _state.userId;

  /// Get current user email
  String? get email => _state.email;

  /// Get current user display name
  String? get displayName => _state.displayName;

  /// Get error message
  String? get errorMessage => _state.errorMessage;

  /// Initialize provider - load saved authentication state if any
  Future<void> initialize() async {
    _updateState(_state.copyWith(isLoading: true));
    
    try {
      // TODO: Implement initialization logic
      // For example: load saved user session from secure storage
      // await _loadSavedSession();
      
      _updateState(_state.copyWith(isLoading: false));
    } catch (e) {
      _updateState(
        _state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to initialize authentication: $e',
        ),
      );
    }
  }

  /// Login with email and password
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _updateState(_state.copyWith(
      isLoading: true,
      errorMessage: null,
    ));

    try {
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password cannot be empty');
      }

      // Validate email format
      if (!_isValidEmail(email)) {
        throw Exception('Invalid email format');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      // TODO: Implement actual login logic with your backend/authentication service
      // Example:
      // final response = await _authService.login(email: email, password: password);
      // final user = response.user;

      // Mock successful login for demonstration
      _updateState(
        _state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          displayName: email.split('@')[0],
          errorMessage: null,
          lastAuthTime: DateTime.now(),
        ),
      );

      return true;
    } catch (e) {
      _updateState(
        _state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
      return false;
    }
  }

  /// Register a new user
  Future<bool> register({
    required String email,
    required String password,
    required String confirmPassword,
    String? displayName,
  }) async {
    _updateState(_state.copyWith(
      isLoading: true,
      errorMessage: null,
    ));

    try {
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password cannot be empty');
      }

      // Validate email format
      if (!_isValidEmail(email)) {
        throw Exception('Invalid email format');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      if (password != confirmPassword) {
        throw Exception('Passwords do not match');
      }

      if (displayName != null && displayName.isEmpty) {
        throw Exception('Display name cannot be empty');
      }

      // TODO: Implement actual registration logic with your backend/authentication service
      // Example:
      // final response = await _authService.register(
      //   email: email,
      //   password: password,
      //   displayName: displayName,
      // );

      // Mock successful registration for demonstration
      _updateState(
        _state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          displayName: displayName ?? email.split('@')[0],
          errorMessage: null,
          lastAuthTime: DateTime.now(),
        ),
      );

      return true;
    } catch (e) {
      _updateState(
        _state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
      return false;
    }
  }

  /// Logout current user
  Future<void> logout() async {
    _updateState(_state.copyWith(isLoading: true));

    try {
      // TODO: Implement logout logic
      // For example: clear saved session from secure storage
      // await _authService.logout();
      // await _clearSavedSession();

      _updateState(
        const AuthState(
          isAuthenticated: false,
          isLoading: false,
          errorMessage: null,
        ),
      );
    } catch (e) {
      _updateState(
        _state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to logout: $e',
        ),
      );
    }
  }

  /// Clear error message
  void clearError() {
    _updateState(_state.copyWith(errorMessage: null));
  }

  /// Update authentication state and notify listeners
  void _updateState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Validate email format
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Reset authentication state
  void reset() {
    _updateState(const AuthState());
  }
}
