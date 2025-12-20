import 'dart:async';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._();
  
  DatabaseService._() {
    // Initialize with some mock data
    _initializeMockData();
  }
  
  // ============ EVENT MANAGEMENT ============
  final List<Map<String, dynamic>> _events = [];
  int _nextEventId = 3; // Start after mock events
  
  // ============ NOTIFICATIONS ============
  final List<Map<String, dynamic>> _notifications = [];
  int _nextNotificationId = 1;
  
  // ============ PICKUP REQUESTS ============
  final List<Map<String, dynamic>> _mockPickupRequests = [];
  int _nextRequestId = 1;
  
  // ============ USER DATA ============
  final List<Map<String, dynamic>> _users = [];
  int _nextUserId = 1;
  
  // ============ BLOG POSTS ============
  final List<Map<String, dynamic>> _blogPosts = [];
  int _nextBlogPostId = 1;
  
  // ============ TIPS ============
  final List<Map<String, dynamic>> _tips = [];
  int _nextTipId = 1;
  
  // Initialize with mock data
  void _initializeMockData() {
    // Add mock events
    _events.addAll([
      {
        'id': 1,
        'title': 'Community Cleanup Day',
        'description': 'Join us for a community cleanup event at Central Park. We\'ll provide gloves, bags, and refreshments.',
        'date': DateTime.now().add(Duration(days: 7)).toIso8601String(),
        'time': '9:00 AM',
        'location': 'Central Park',
        'organizer': 'Green Earth Initiative',
        'participants': 15,
        'rsvps': [],
        'category': 'cleanup',
        'createdAt': DateTime.now().subtract(Duration(days: 2)).toIso8601String(),
      },
      {
        'id': 2,
        'title': 'Recycling Workshop',
        'description': 'Learn about proper recycling techniques and how to reduce waste in your daily life.',
        'date': DateTime.now().add(Duration(days: 14)).toIso8601String(),
        'time': '2:00 PM',
        'location': 'Community Center',
        'organizer': 'Recycle Now',
        'participants': 8,
        'rsvps': [],
        'category': 'workshop',
        'createdAt': DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
      },
    ]);
    
    // Add mock pickup requests
    _mockPickupRequests.addAll([
      {
        'id': 1,
        'userId': 1,
        'userName': 'John Doe',
        'location': '123 Main St',
        'date': '2024-01-15',
        'time': '10:00 AM',
        'status': 'pending',
        'type': 'Plastic Waste',
        'totalItems': 5,
        'itemsBreakdown': 'Plastic bottles: 3, Plastic bags: 2',
        'createdAt': DateTime.now().subtract(Duration(days: 2)).toIso8601String(),
      },
    ]);
    
    // Add mock users
    _users.addAll([
      {
        'id': 1,
        'email': 'admin@cleanroute.com',
        'password': 'admin123',
        'firstName': 'Admin',
        'lastName': 'User',
        'phone': '+250 123 456 789',
        'location': 'Kigali, Rwanda',
        'role': 'admin',
        'points': 500,
        'createdAt': DateTime.now().subtract(Duration(days: 30)).toIso8601String(),
      },
      {
        'id': 2,
        'email': 'user@example.com',
        'password': 'user123',
        'firstName': 'Regular',
        'lastName': 'User',
        'phone': '+250 987 654 321',
        'location': 'Nyarugenge, Kiyovu',
        'role': 'user',
        'points': 100,
        'createdAt': DateTime.now().subtract(Duration(days: 15)).toIso8601String(),
      },
    ]);
    _nextUserId = 3;
    
    // Add mock blog posts
    _blogPosts.addAll([
      {
        'id': 1,
        'title': 'The Future of Recycling',
        'content': 'New technologies are revolutionizing how we recycle. From AI-powered sorting to chemical recycling, discover what\'s next for the industry.',
        'author': 'Dr. Emily Green',
        'date': DateTime.now().subtract(Duration(days: 2)).toIso8601String(),
        'readTime': '5 min',
        'imageUrl': 'https://example.com/future.jpg',
        'likes': 124,
        'comments': 23,
      },
      {
        'id': 2,
        'title': 'How to Start a Zero Waste Lifestyle',
        'content': 'Transitioning to zero waste doesn\'t happen overnight. Here\'s a practical guide to reduce your waste footprint step by step.',
        'author': 'Sarah Eco',
        'date': DateTime.now().subtract(Duration(days: 5)).toIso8601String(),
        'readTime': '8 min',
        'imageUrl': 'https://example.com/zerowaste.jpg',
        'likes': 89,
        'comments': 15,
      },
    ]);
    _nextBlogPostId = 3;
    
    // Add mock tips
    _tips.addAll([
      {
        'id': 1,
        'title': 'Sort Your Waste Properly',
        'content': 'Always separate recyclables from non-recyclables. Paper, plastic, glass, and metal should be clean and dry before recycling.',
        'category': 'recycling',
        'author': 'Recycling Expert',
        'imageUrl': 'https://example.com/sorting.jpg',
      },
      {
        'id': 2,
        'title': 'Reduce Plastic Use',
        'content': 'Use reusable bags, containers, and water bottles. Avoid single-use plastics whenever possible.',
        'category': 'reduction',
        'author': 'Eco Warrior',
        'imageUrl': 'https://example.com/plastic.jpg',
      },
    ]);
    _nextTipId = 3;
  }
  
  // ============ EVENT METHODS ============
  
  Future<void> createEvent(Map<String, dynamic> eventData) async {
    final newEvent = {
      ...eventData,
      'id': _nextEventId++,
      'createdAt': DateTime.now().toIso8601String(),
      'participants': eventData['participants'] ?? 0,
      'rsvps': eventData['rsvps'] ?? [],
    };
    
    _events.add(newEvent);
    print('✅ Event created: ${newEvent['title']}');
    await Future.delayed(Duration(milliseconds: 100));
  }
  
  Future<List<Map<String, dynamic>>> getEvents() async {
    await Future.delayed(Duration(milliseconds: 100));
    return List.from(_events);
  }
  
  Future<List<Map<String, dynamic>>> getEventsByMonth(String month) async {
    await Future.delayed(Duration(milliseconds: 100));
    return _events.where((event) {
      final date = DateTime.parse(event['date']);
      final monthNames = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ];
      return monthNames[date.month - 1] == month;
    }).toList();
  }
  
  Future<void> rsvpToEvent(int eventId, int userId, String userName) async {
    final index = _events.indexWhere((event) => event['id'] == eventId);
    if (index != -1) {
      if (!_events[index]['rsvps'].contains(userId)) {
        _events[index]['rsvps'].add(userId);
        _events[index]['participants'] = _events[index]['rsvps'].length;
        
        // Send notification
        await addNotification(
          userId: 1, // Admin ID
          title: '🎉 New RSVP for ${_events[index]['title']}',
          message: '$userName has RSVP\'d to your event "${_events[index]['title']}"',
          type: 'event_rsvp',
          data: {
            'eventId': eventId,
            'eventTitle': _events[index]['title'],
            'userId': userId,
            'userName': userName,
          },
        );
        
        print('✅ User $userId RSVP\'d to event $eventId');
      }
    }
    await Future.delayed(Duration(milliseconds: 50));
  }
  
  Future<void> deleteEvent(int eventId) async {
    _events.removeWhere((event) => event['id'] == eventId);
    print('🗑️ Event $eventId deleted');
    await Future.delayed(Duration(milliseconds: 50));
  }
  
  // ============ NOTIFICATION METHODS ============
  
  Future<void> addNotification({
    required int userId,
    required String title,
    required String message,
    required String type,
    Map<String, dynamic>? data,
  }) async {
    final notification = {
      'id': _nextNotificationId++,
      'userId': userId,
      'title': title,
      'message': message,
      'type': type,
      'data': data ?? {},
      'read': false,
      'createdAt': DateTime.now().toIso8601String(),
    };
    
    _notifications.add(notification);
    print('📢 Notification created for user $userId: $title');
    await Future.delayed(Duration(milliseconds: 50));
  }
  
  Future<List<Map<String, dynamic>>> getUserNotifications(int userId) async {
    await Future.delayed(Duration(milliseconds: 50));
    return _notifications
        .where((notification) => notification['userId'] == userId)
        .toList()
        .reversed
        .toList(); // Newest first
  }
  
  Future<void> markNotificationAsRead(int notificationId) async {
    await Future.delayed(Duration(milliseconds: 50));
    final index = _notifications.indexWhere((n) => n['id'] == notificationId);
    if (index != -1) {
      _notifications[index]['read'] = true;
    }
  }
  
  Future<int> getUnreadNotificationCount(int userId) async {
    await Future.delayed(Duration(milliseconds: 50));
    return _notifications
        .where((n) => n['userId'] == userId && !n['read'])
        .length;
  }
  
  // ============ PICKUP REQUEST METHODS ============
  
  Future<void> createPickupRequest(Map<String, dynamic> requestData) async {
    final newRequest = {
      ...requestData,
      'id': _nextRequestId++,
      'status': 'pending',
      'createdAt': DateTime.now().toIso8601String(),
      'requestNumber': 'REQ${(_nextRequestId - 1).toString().padLeft(4, '0')}',
    };
    
    _mockPickupRequests.add(newRequest);
    print('✅ Pickup request created: ${newRequest['requestNumber']}');
    
    await Future.delayed(Duration(milliseconds: 100));
  }
  
  Future<List<Map<String, dynamic>>> getPickupRequests() async {
    await Future.delayed(Duration(milliseconds: 100));
    return List.from(_mockPickupRequests);
  }
  
  Future<List<Map<String, dynamic>>> getUserPickupRequests(String userId) async {
    await Future.delayed(Duration(milliseconds: 50));
    final id = int.tryParse(userId) ?? 0;
    return _mockPickupRequests
        .where((request) => request['userId'] == id)
        .toList();
  }
  
  Future<void> updatePickupRequestWithNotification(
    int requestId, 
    Map<String, dynamic> updates,
    int userId,
    String userName,
  ) async {
    print('Updating pickup request $requestId with: $updates');
    
    final index = _mockPickupRequests.indexWhere((req) => req['id'] == requestId);
    if (index != -1) {
      final oldStatus = _mockPickupRequests[index]['status'];
      final newStatus = updates['status'];
      
      // Update the request
      _mockPickupRequests[index] = {
        ..._mockPickupRequests[index],
        ...updates,
        'updatedAt': DateTime.now().toIso8601String(),
      };
      
      // Send notification based on status change
      if (oldStatus != newStatus) {
        await _sendStatusChangeNotification(
          userId: userId,
          userName: userName,
          requestId: requestId,
          oldStatus: oldStatus,
          newStatus: newStatus,
          pickupData: _mockPickupRequests[index],
        );
      }
      
      print('✅ Pickup request $requestId updated successfully');
    } else {
      print('❌ Pickup request $requestId not found');
    }
    
    await Future.delayed(Duration(milliseconds: 100));
  }
  
  Future<void> _sendStatusChangeNotification({
    required int userId,
    required String userName,
    required int requestId,
    required String oldStatus,
    required String newStatus,
    required Map<String, dynamic> pickupData,
  }) async {
    String title = '';
    String message = '';
    String type = '';
    
    switch (newStatus.toLowerCase()) {
      case 'confirmed':
        title = '✅ Pickup Request Confirmed';
        message = 'Your pickup request #REQ${requestId.toString().padLeft(3, '0')} has been approved! Our team will arrive at ${pickupData['time']} on ${pickupData['date']}.';
        type = 'pickup_approved';
        break;
        
      case 'rejected':
        title = '❌ Pickup Request Rejected';
        message = 'Your pickup request #REQ${requestId.toString().padLeft(3, '0')} has been rejected. Please contact support for more information.';
        type = 'pickup_rejected';
        break;
        
      case 'completed':
        title = '🎉 Pickup Completed';
        message = 'Great news! Your pickup request #REQ${requestId.toString().padLeft(3, '0')} has been completed. Thank you for recycling with us!';
        type = 'pickup_completed';
        break;
        
      default:
        title = '📋 Pickup Status Updated';
        message = 'Your pickup request #REQ${requestId.toString().padLeft(3, '0')} status changed from $oldStatus to $newStatus.';
        type = 'status_update';
    }
    
    await addNotification(
      userId: userId,
      title: title,
      message: message,
      type: type,
      data: {
        'requestId': requestId,
        'oldStatus': oldStatus,
        'newStatus': newStatus,
        'pickupData': pickupData,
      },
    );
  }
  
  // ============ USER METHODS ============
  
  Future<Map<String, dynamic>?> getUser(String userId) async {
    await Future.delayed(Duration(milliseconds: 50));
    final id = int.tryParse(userId) ?? 0;
    
    try {
      final user = _users.firstWhere((user) => user['id'] == id);
      return Map<String, dynamic>.from(user);
    } catch (e) {
      return null; // User not found
    }
  }
  
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    await Future.delayed(Duration(milliseconds: 50));
    
    try {
      final user = _users.firstWhere((user) => user['email'] == email);
      return Map<String, dynamic>.from(user);
    } catch (e) {
      return null; // User not found
    }
  }
  
  Future<void> createUser(Map<String, dynamic> userData) async {
    final newUser = {
      ...userData,
      'id': _nextUserId++,
      'createdAt': DateTime.now().toIso8601String(),
      'points': 0,
      'role': userData['role'] ?? 'user',
    };
    
    _users.add(newUser);
    print('✅ User created: ${newUser['email']}');
    await Future.delayed(Duration(milliseconds: 100));
  }
  
  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    final id = int.tryParse(userId) ?? 0;
    final index = _users.indexWhere((user) => user['id'] == id);
    if (index != -1) {
      _users[index] = {
        ..._users[index],
        ...updates,
      };
      print('✅ User $userId updated');
    }
    await Future.delayed(Duration(milliseconds: 50));
  }
  
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    await Future.delayed(Duration(milliseconds: 100));
    return List.from(_users);
  }
  
  // ============ BLOG METHODS ============
  
  Future<List<Map<String, dynamic>>> getBlogPosts() async {
    await Future.delayed(Duration(milliseconds: 100));
    return List.from(_blogPosts);
  }
  
  Future<void> createBlogPost(Map<String, dynamic> postData) async {
    final newPost = {
      ...postData,
      'id': _nextBlogPostId++,
      'createdAt': DateTime.now().toIso8601String(),
      'likes': 0,
      'comments': 0,
    };
    
    _blogPosts.add(newPost);
    print('✅ Blog post created: ${newPost['title']}');
    await Future.delayed(Duration(milliseconds: 100));
  }
  
  Future<void> deleteBlogPost(int postId) async {
    _blogPosts.removeWhere((post) => post['id'] == postId);
    print('🗑️ Blog post $postId deleted');
    await Future.delayed(Duration(milliseconds: 50));
  }
  
  // ============ TIPS METHODS ============
  
  Future<List<Map<String, dynamic>>> getTips() async {
    await Future.delayed(Duration(milliseconds: 100));
    return List.from(_tips);
  }
  
  Future<void> createTip(Map<String, dynamic> tipData) async {
    final newTip = {
      ...tipData,
      'id': _nextTipId++,
      'createdAt': DateTime.now().toIso8601String(),
    };
    
    _tips.add(newTip);
    print('✅ Tip created: ${newTip['title']}');
    await Future.delayed(Duration(milliseconds: 100));
  }
  
  Future<void> deleteTip(int tipId) async {
    _tips.removeWhere((tip) => tip['id'] == tipId);
    print('🗑️ Tip $tipId deleted');
    await Future.delayed(Duration(milliseconds: 50));
  }
  
  // ============ UTILITY METHODS ============
  
  Future<void> clearAllData() async {
    _events.clear();
    _notifications.clear();
    _mockPickupRequests.clear();
    _users.clear();
    _blogPosts.clear();
    _tips.clear();
    
    _nextEventId = 1;
    _nextNotificationId = 1;
    _nextRequestId = 1;
    _nextUserId = 1;
    _nextBlogPostId = 1;
    _nextTipId = 1;
    
    print('🗑️ All data cleared');
    await Future.delayed(Duration(milliseconds: 100));
  }
  
  // Get statistics
  Future<Map<String, dynamic>> getStatistics() async {
    await Future.delayed(Duration(milliseconds: 100));
    
    return {
      'totalUsers': _users.length,
      'totalEvents': _events.length,
      'totalPickupRequests': _mockPickupRequests.length,
      'totalBlogPosts': _blogPosts.length,
      'totalTips': _tips.length,
      'pendingPickups': _mockPickupRequests.where((req) => req['status'] == 'pending').length,
      'completedPickups': _mockPickupRequests.where((req) => req['status'] == 'completed').length,
    };
  }
  
  // Search events
  Future<List<Map<String, dynamic>>> searchEvents(String query) async {
    await Future.delayed(Duration(milliseconds: 100));
    if (query.isEmpty) return _events;
    
    return _events.where((event) {
      final title = event['title']?.toString().toLowerCase() ?? '';
      final description = event['description']?.toString().toLowerCase() ?? '';
      final location = event['location']?.toString().toLowerCase() ?? '';
      final search = query.toLowerCase();
      
      return title.contains(search) || 
             description.contains(search) || 
             location.contains(search);
    }).toList();
  }
  
  // Get upcoming events
  Future<List<Map<String, dynamic>>> getUpcomingEvents() async {
    await Future.delayed(Duration(milliseconds: 100));
    final now = DateTime.now();
    
    return _events.where((event) {
      final date = DateTime.parse(event['date']);
      return date.isAfter(now);
    }).toList();
  }
}