import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import '../screens/adminuser_screen.dart';

// ==================== MAIN ADMIN DASHBOARD ====================
class AdminDashboard extends StatefulWidget {
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    AdminHomeScreen(),
    AdminUsersScreen(),
    AdminPickupRequestsScreen(),
    AdminEventsScreen(), // Added Events screen
    AdminSupportTicketsScreen(),
    AdminPaymentsScreen(),
    AdminAnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Pickups'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'), // Added Events tab
          BottomNavigationBarItem(icon: Icon(Icons.support_agent), label: 'Support'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payments'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'),
        ],
      ),
    );
  }
}

// ==================== ADMIN HOME SCREEN ====================
class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.event),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminEventsScreen()),
              );
            },
            tooltip: 'Manage Events',
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminNotificationsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back, Admin!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'CleanRoute Management Portal',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Pending Requests Alert
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: Colors.orange),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '5 Pending Pickup Requests • 3 Support Tickets • 2 Upcoming Events',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Stats Grid
            Text(
              'Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                _buildStatCard(
                  icon: Icons.people,
                  title: 'Total Users',
                  value: '1,234',
                  color: Colors.blue,
                ),
                _buildStatCard(
                  icon: Icons.local_shipping,
                  title: 'Pickups Today',
                  value: '45',
                  color: Colors.green,
                ),
                _buildStatCard(
                  icon: Icons.event,
                  title: 'Upcoming Events',
                  value: '12',
                  color: Colors.purple,
                ),
                _buildStatCard(
                  icon: Icons.attach_money,
                  title: 'Revenue (Month)',
                  value: 'Rs. 245K',
                  color: Colors.orange,
                ),
                _buildStatCard(
                  icon: Icons.eco,
                  title: 'Trees Planted',
                  value: '892',
                  color: Colors.teal,
                ),
                _buildStatCard(
                  icon: Icons.support_agent,
                  title: 'Active Tickets',
                  value: '8',
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Quick Actions
            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildActionButton(
              context,
              icon: Icons.person_add,
              title: 'Add New User',
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUserScreen()),
                );
              },
            ),
            _buildActionButton(
              context,
              icon: Icons.local_shipping,
              title: 'View Pickup Requests',
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPickupRequestsScreen()),
                );
              },
            ),
            _buildActionButton(
              context,
              icon: Icons.event,
              title: 'Manage Events',
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminEventsScreen()),
                );
              },
            ),
            _buildActionButton(
              context,
              icon: Icons.support_agent,
              title: 'Support Tickets',
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminSupportTicketsScreen()),
                );
              },
            ),
            _buildActionButton(
              context,
              icon: Icons.payment,
              title: 'View Payments',
              color: Colors.teal,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPaymentsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: color),
          ),
          const SizedBox(height: 15),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to sign in screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logged out successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

// ==================== ADMIN USERS SCREEN ====================


// ==================== ADMIN PICKUP REQUESTS SCREEN ====================
class AdminPickupRequestsScreen extends StatefulWidget {
  @override
  State<AdminPickupRequestsScreen> createState() =>
      _AdminPickupRequestsScreenState();
}

class _AdminPickupRequestsScreenState extends State<AdminPickupRequestsScreen> {
  List<Map<String, dynamic>> pickupRequests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPickupRequests();
  }

  Future<void> _loadPickupRequests() async {
    try {
      final requests = await DatabaseService.instance.getPickupRequests();
      
      setState(() {
        pickupRequests = requests.map((request) {
          return {
            'id': request['id'] ?? 0,
            'displayId': 'REQ${(request['id'] ?? 0).toString().padLeft(3, '0')}',
            'userId': request['userId'] ?? 0,
            'user': request['userName'] ?? 'User #${request['userId'] ?? 0}',
            'location': request['location'] ?? 'Unknown Location',
            'date': request['date'] ?? 'Unknown Date',
            'time': request['time'] ?? 'Unknown Time',
            'status': request['status'] ?? 'Pending',
            'type': request['type'] ?? 'General Waste',
            'createdAt': request['createdAt'] ?? DateTime.now().toString(),
            'totalItems': request['totalItems'] ?? 0,
            'itemsBreakdown': request['itemsBreakdown'] ?? '',
            'userName': request['userName'] ?? 'User',
          };
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error loading pickup requests: $e');
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading requests: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Pickup Requests'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              _loadPickupRequests();
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : pickupRequests.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_shipping_outlined,
                          size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No pickup requests yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'When users schedule pickups, they will appear here',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        icon: Icon(Icons.refresh),
                        label: Text('Refresh'),
                        onPressed: _loadPickupRequests,
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadPickupRequests,
                  child: ListView.builder(
                    padding: EdgeInsets.all(15),
                    itemCount: pickupRequests.length,
                    itemBuilder: (context, index) {
                      final request = pickupRequests[index];
                      Color statusColor = request['status'] == 'Pending'
                          ? Colors.orange
                          : request['status'] == 'Confirmed'
                              ? Colors.blue
                              : request['status'] == 'Completed'
                                  ? Colors.green
                                  : Colors.red;

                      return Card(
                        margin: EdgeInsets.only(bottom: 15),
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    request['displayId'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      request['status'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              _buildInfoRow(
                                  Icons.person, 'User:', request['user']),
                              _buildInfoRow(Icons.location_on, 'Location:',
                                  request['location']),
                              _buildInfoRow(Icons.calendar_today, 'Date:',
                                  request['date']),
                              _buildInfoRow(
                                  Icons.access_time, 'Time:', request['time']),
                              _buildInfoRow(Icons.list, 'Items:',
                                  '${request['totalItems']} total'),
                              if (request['itemsBreakdown'].isNotEmpty)
                                _buildInfoRow(Icons.description, 'Details:',
                                    request['itemsBreakdown']),
                              const SizedBox(height: 15),
                              if (request['status'] == 'Pending')
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _confirmPickup(context, request);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                        ),
                                        child: Text('Confirm'),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          _rejectPickup(context, request);
                                        },
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.red,
                                        ),
                                        child: Text('Reject'),
                                      ),
                                    ),
                                  ],
                                ),
                              if (request['status'] == 'Confirmed')
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _markCompleted(context, request);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: Text('Mark as Completed'),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmPickup(BuildContext context, Map<String, dynamic> request) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Pickup'),
        content: Text(
            'Confirm pickup request ${request['displayId']} for ${request['user']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final userId = request['userId'];
                final userName = request['userName'] ?? request['user'];
                
                await DatabaseService.instance.updatePickupRequestWithNotification(
                  request['id'],
                  {'status': 'Confirmed'},
                  userId,
                  userName,
                );
                
                setState(() {
                  request['status'] = 'Confirmed';
                });
                
                _loadPickupRequests();
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('✅ Pickup ${request['displayId']} confirmed & user notified'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error confirming pickup: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _rejectPickup(BuildContext context, Map<String, dynamic> request) {
    final TextEditingController reasonController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reject Pickup'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Reason for rejection:'),
            const SizedBox(height: 10),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter reason...',
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final userId = request['userId'];
                final userName = request['userName'] ?? request['user'];
                
                await DatabaseService.instance.updatePickupRequestWithNotification(
                  request['id'],
                  {
                    'status': 'Rejected',
                    'rejectionReason': reasonController.text,
                  },
                  userId,
                  userName,
                );
                
                setState(() {
                  request['status'] = 'Rejected';
                });
                
                _loadPickupRequests();
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('❌ Pickup ${request['displayId']} rejected & user notified'),
                    backgroundColor: Colors.red,
                  ),
                );
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error rejecting pickup: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Reject'),
          ),
        ],
      ),
    );
  }

  void _markCompleted(BuildContext context, Map<String, dynamic> request) async {
    try {
      final userId = request['userId'];
      final userName = request['userName'] ?? request['user'];
      
      await DatabaseService.instance.updatePickupRequestWithNotification(
        request['id'],
        {'status': 'Completed'},
        userId,
        userName,
      );
      
      setState(() {
        request['status'] = 'Completed';
      });
      
      _loadPickupRequests();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Pickup ${request['displayId']} marked as completed & user notified'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error marking pickup as completed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

// ==================== ADMIN EVENTS SCREEN ====================
class AdminEventsScreen extends StatefulWidget {
  @override
  State<AdminEventsScreen> createState() => _AdminEventsScreenState();
}

class _AdminEventsScreenState extends State<AdminEventsScreen> {
  List<Map<String, dynamic>> _events = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      final events = await DatabaseService.instance.getEvents();
      setState(() {
        _events = events;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading events: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Events'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              _loadEvents();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateEventDialog(context);
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _events.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.event_note, size: 64, color: Colors.grey[400]),
                      SizedBox(height: 16),
                      Text(
                        'No events created yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Create your first event using the + button',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadEvents,
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      final event = _events[index];
                      final date = DateTime.parse(event['date']);
                      
                      return Card(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      event['title'] ?? 'Untitled',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  PopupMenuButton(
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text('Edit'),
                                        value: 'edit',
                                      ),
                                      PopupMenuItem(
                                        child: Text('Delete', style: TextStyle(color: Colors.red)),
                                        value: 'delete',
                                      ),
                                    ],
                                    onSelected: (value) async {
                                      if (value == 'delete') {
                                        _deleteEvent(event['id']);
                                      } else if (value == 'edit') {
                                        _showEditEventDialog(context, event);
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                event['description'] ?? 'No description',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              SizedBox(height: 12),
                              Divider(),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                                  SizedBox(width: 8),
                                  Text(event['location'] ?? 'Location not set'),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                                  SizedBox(width: 8),
                                  Text('${date.day}/${date.month}/${date.year}'),
                                  SizedBox(width: 16),
                                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                                  SizedBox(width: 8),
                                  Text(event['time'] ?? 'TBD'),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.people, size: 16, color: Colors.grey[600]),
                                  SizedBox(width: 8),
                                  Text('${event['participants'] ?? 0} attending'),
                                ],
                              ),
                              if (event['rsvps'] != null && event['rsvps'].isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8),
                                    Text(
                                      'RSVPs: ${event['rsvps'].length} users',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  void _showCreateEventDialog(BuildContext context) {
    final _titleController = TextEditingController();
    final _descController = TextEditingController();
    final _locationController = TextEditingController();
    final _timeController = TextEditingController();
    DateTime _selectedDate = DateTime.now().add(Duration(days: 7));

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Create New Event'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Event Title *',
                        border: OutlineInputBorder(),
                        hintText: 'Enter event title',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _descController,
                      decoration: InputDecoration(
                        labelText: 'Description *',
                        border: OutlineInputBorder(),
                        hintText: 'Enter event description',
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location *',
                        border: OutlineInputBorder(),
                        hintText: 'Enter event location',
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _timeController,
                            decoration: InputDecoration(
                              labelText: 'Time *',
                              border: OutlineInputBorder(),
                              hintText: 'e.g., 2:00 PM',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    ElevatedButton.icon(
                      icon: Icon(Icons.calendar_today),
                      label: Text('Select Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025, 12, 31),
                        );
                        if (date != null) {
                          setState(() {
                            _selectedDate = date;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_titleController.text.isEmpty ||
                        _descController.text.isEmpty ||
                        _locationController.text.isEmpty ||
                        _timeController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill all required fields'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                      return;
                    }

                    try {
                      await DatabaseService.instance.createEvent({
                        'title': _titleController.text,
                        'description': _descController.text,
                        'location': _locationController.text,
                        'date': _selectedDate.toIso8601String(),
                        'time': _timeController.text,
                        'organizer': 'Admin',
                        'category': 'community',
                        'participants': 0,
                        'rsvps': [],
                      });

                      Navigator.pop(context);
                      _loadEvents();
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('✅ Event created successfully!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Create Event'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditEventDialog(BuildContext context, Map<String, dynamic> event) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit feature coming soon'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Future<void> _deleteEvent(int eventId) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Event'),
        content: Text('Are you sure you want to delete this event?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await DatabaseService.instance.deleteEvent(eventId);
                _loadEvents();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('✅ Event deleted successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error deleting event: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// ==================== ADMIN SUPPORT TICKETS SCREEN ====================
class AdminSupportTicketsScreen extends StatefulWidget {
  @override
  State<AdminSupportTicketsScreen> createState() =>
      _AdminSupportTicketsScreenState();
}

class _AdminSupportTicketsScreenState extends State<AdminSupportTicketsScreen> {
  final List<Map<String, dynamic>> supportTickets = [
    {
      'id': 'TKT001',
      'user': 'Ineza Marie',
      'category': 'Missed Pickup',
      'subject': 'Bin not collected on time',
      'description': 'My bin was not collected yesterday as scheduled.',
      'date': '2024-12-08',
      'status': 'Open',
      'priority': 'High',
    },
    {
      'id': 'TKT002',
      'user': 'Uwase Jean',
      'category': 'Billing Issue',
      'subject': 'Incorrect bill amount',
      'description': 'I was charged more than expected this month.',
      'date': '2024-12-07',
      'status': 'Open',
      'priority': 'Medium',
    },
    {
      'id': 'TKT003',
      'user': 'Mutoni Alice',
      'category': 'Damaged Bin',
      'subject': 'Bin has a crack',
      'description': 'My waste bin has developed a large crack on the side.',
      'date': '2024-12-06',
      'status': 'In Progress',
      'priority': 'Low',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Support Tickets'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: supportTickets.length,
        itemBuilder: (context, index) {
          final ticket = supportTickets[index];
          Color statusColor = ticket['status'] == 'Open'
              ? Colors.red
              : ticket['status'] == 'In Progress'
                  ? Colors.orange
                  : Colors.green;

          Color priorityColor = ticket['priority'] == 'High'
              ? Colors.red
              : ticket['priority'] == 'Medium'
                  ? Colors.orange
                  : Colors.blue;

          return Card(
            margin: EdgeInsets.only(bottom: 15),
            child: ExpansionTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      ticket['subject'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: priorityColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      ticket['priority'],
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text('${ticket['id']} • ${ticket['user']}'),
                  Text(
                    '${ticket['category']} • ${ticket['date']}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              leading: Icon(Icons.support_agent, color: Colors.deepPurple),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  ticket['status'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(ticket['description']),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          if (ticket['status'] == 'Open')
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _assignTicket(context, ticket);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                                child: Text('Assign to Me'),
                              ),
                            ),
                          if (ticket['status'] == 'In Progress') ...[
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _resolveTicket(context, ticket);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: Text('Resolve'),
                              ),
                            ),
                          ],
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _replyToTicket(context, ticket);
                              },
                              child: Text('Reply'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _assignTicket(BuildContext context, Map ticket) {
    setState(() {
      ticket['status'] = 'In Progress';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ticket ${ticket['id']} assigned to you'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _resolveTicket(BuildContext context, Map ticket) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Resolve Ticket'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add resolution notes:'),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Resolution details...',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                ticket['status'] = 'Resolved';
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Ticket ${ticket['id']} resolved'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Resolve'),
          ),
        ],
      ),
    );
  }

  void _replyToTicket(BuildContext context, Map ticket) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reply to Ticket'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Your reply',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Reply sent to ${ticket['user']}')),
              );
            },
            child: Text('Send Reply'),
          ),
        ],
      ),
    );
  }
}

// ==================== ADMIN PAYMENTS SCREEN ====================
class AdminPaymentsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> payments = [
    {
      'id': 'PAY001',
      'user': 'Ineza Marie',
      'amount': 'Rs. 500',
      'date': '2024-12-08',
      'method': 'Mobile Money',
      'status': 'Completed',
    },
    {
      'id': 'PAY002',
      'user': 'Uwase Jean',
      'amount': 'Rs. 310',
      'date': '2024-12-07',
      'method': 'Credit Card',
      'status': 'Completed',
    },
    {
      'id': 'PAY003',
      'user': 'Mutoni Alice',
      'amount': 'Rs. 1,200',
      'date': '2024-12-06',
      'method': 'Pending',
      'status': 'Pending',
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Payment Records'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Cards
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    'Total Revenue',
                    'Rs. 245,000',
                    Colors.green,
                    Icons.trending_up,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildSummaryCard(
                    'Pending',
                    'Rs. 12,500',
                    Colors.orange,
                    Icons.pending,
                  ),
                ),
              ],
            ),
          ),
          // Payment List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              itemCount: payments.length,
              itemBuilder: (context, index) {
                final payment = payments[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: payment['status'] == 'Completed'
                          ? Colors.green
                          : Colors.orange,
                      child: Icon(
                        payment['status'] == 'Completed'
                            ? Icons.check
                            : Icons.pending,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      '${payment['user']} - ${payment['amount']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${payment['method']} • ${payment['date']}',
                    ),
                    trailing: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: payment['status'] == 'Completed'
                            ? Colors.green
                            : Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        payment['status'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      _showPaymentDetails(context, payment);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSummaryCard(
    String title, String amount, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 5),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  void _showPaymentDetails(BuildContext context, Map payment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Payment ID:', payment['id']),
            _buildDetailRow('User:', payment['user']),
            _buildDetailRow('Amount:', payment['amount']),
            _buildDetailRow('Date:', payment['date']),
            _buildDetailRow('Method:', payment['method']),
            _buildDetailRow('Status:', payment['status']),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          if (payment['status'] == 'Pending')
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Payment marked as completed')),
                );
              },
              child: Text('Mark Paid'),
            ),
        ],
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

// ==================== ADMIN ANALYTICS SCREEN ====================
class AdminAnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Analytics & Reports'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time Period Selector
            Row(
              children: [
                Expanded(
                  child: _buildPeriodButton('Today', true),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildPeriodButton('Week', false),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildPeriodButton('Month', false),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Key Metrics
            Text(
              'Key Metrics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminUsersScreen(),
      ),
    );
  },
  child: _buildMetricCard(
    'New Users',
    '45',
    '+12% from yesterday',
    Colors.blue,
    Icons.person_add,
  ),
),

            _buildMetricCard(
              'Pickups Completed',
              '128',
              '+8% from yesterday',
              Colors.green,
              Icons.check_circle,
            ),
            _buildMetricCard(
              'Events Created',
              '12',
              '+3 from last week',
              Colors.purple,
              Icons.event,
            ),
            _buildMetricCard(
              'Revenue Generated',
              'Rs. 12,500',
              '+15% from yesterday',
              Colors.orange,
              Icons.attach_money,
            ),
            _buildMetricCard(
              'Trees Planted',
              '23',
              '+5 from yesterday',
              Colors.teal,
              Icons.eco,
            ),
            const SizedBox(height: 25),

            // Performance Indicators
            Text(
              'Performance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildPerformanceIndicator('Customer Satisfaction', 0.92, Colors.green),
            _buildPerformanceIndicator('On-Time Pickups', 0.85, Colors.blue),
            _buildPerformanceIndicator('Event Attendance', 0.78, Colors.purple),
            _buildPerformanceIndicator('Payment Collection', 0.88, Colors.orange),
            const SizedBox(height: 25),

            // Reports
            Text(
              'Generate Reports',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildReportButton(
              context,
              'User Activity Report',
              Icons.people,
              Colors.blue,
            ),
            _buildReportButton(
              context,
              'Events Report',
              Icons.event,
              Colors.purple,
            ),
            _buildReportButton(
              context,
              'Revenue Report',
              Icons.attach_money,
              Colors.green,
            ),
            _buildReportButton(
              context,
              'Pickup Statistics',
              Icons.local_shipping,
              Colors.orange,
            ),
            _buildReportButton(
              context,
              'Environmental Impact',
              Icons.eco,
              Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPeriodButton(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.deepPurple : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.deepPurple : Colors.grey[300]!,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
  
  Widget _buildMetricCard(
    String title, String value, String change, Color color, IconData icon) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    change,
                    style: TextStyle(fontSize: 12, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPerformanceIndicator(String title, double value, Color color) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  '${(value * 100).toInt()}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildReportButton(
    BuildContext context, String title, IconData icon, Color color) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        trailing: Icon(Icons.download, color: Colors.grey),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Generating $title...')),
          );
        },
      ),
    );
  }
}

// ==================== ADD USER SCREEN ====================
class AddUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New User'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User added successfully')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Add User',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== ADMIN NOTIFICATIONS SCREEN ====================
class AdminNotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          _buildNotification(
            'New pickup request from Ineza Marie',
            '5 minutes ago',
            Icons.local_shipping,
            Colors.green,
          ),
          _buildNotification(
            'New event RSVP from John Doe',
            '15 minutes ago',
            Icons.event,
            Colors.purple,
          ),
          _buildNotification(
            'New support ticket: Billing Issue',
            '1 hour ago',
            Icons.support_agent,
            Colors.orange,
          ),
          _buildNotification(
            'Payment received: Rs. 500',
            '2 hours ago',
            Icons.payment,
            Colors.blue,
          ),
        ],
      ),
    );
  }
  
  Widget _buildNotification(
    String title, String time, IconData icon, Color color) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(time, style: TextStyle(fontSize: 12)),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}