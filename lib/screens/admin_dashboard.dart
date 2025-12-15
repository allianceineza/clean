import 'package:flutter/material.dart';

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
                      '5 Pending Pickup Requests • 3 Support Tickets',
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
class AdminUsersScreen extends StatefulWidget {
  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final List<Map<String, dynamic>> users = [
    {
      'name': 'Ineza Marie',
      'email': 'ineza@example.com',
      'phone': '+250 788 123 456',
      'location': 'Nyarugenge, Kigali',
      'status': 'Active',
      'joined': '2024-01-15',
      'unpaidBills': 'Rs. 500',
    },
    {
      'name': 'Uwase Jean',
      'email': 'uwase@example.com',
      'phone': '+250 788 234 567',
      'location': 'Gasabo, Kigali',
      'status': 'Active',
      'joined': '2024-02-20',
      'unpaidBills': 'Rs. 0',
    },
    {
      'name': 'Mutoni Alice',
      'email': 'mutoni@example.com',
      'phone': '+250 788 345 678',
      'location': 'Kicukiro, Kigali',
      'status': 'Inactive',
      'joined': '2024-03-10',
      'unpaidBills': 'Rs. 1,200',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Manage Users'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text(
                  user['name'][0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                user['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user['email']),
                  Text(user['location'], style: TextStyle(fontSize: 12)),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: user['status'] == 'Active'
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          user['status'],
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (user['unpaidBills'] != 'Rs. 0')
                        Text(
                          'Unpaid: ${user['unpaidBills']}',
                          style: TextStyle(color: Colors.red, fontSize: 11),
                        ),
                    ],
                  ),
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('View Details'),
                    value: 'view',
                  ),
                  PopupMenuItem(
                    child: Text('Edit User'),
                    value: 'edit',
                  ),
                  PopupMenuItem(
                    child: Text('Deactivate'),
                    value: 'deactivate',
                  ),
                  PopupMenuItem(
                    child: Text('Send Notification'),
                    value: 'notify',
                  ),
                ],
                onSelected: (value) {
                  _handleUserAction(context, value.toString(), user);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserScreen()),
          );
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
      ),
    );
  }

  void _handleUserAction(BuildContext context, String action, Map user) {
    switch (action) {
      case 'view':
        _showUserDetails(context, user);
        break;
      case 'edit':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Edit user: ${user['name']}')),
        );
        break;
      case 'deactivate':
        _confirmDeactivate(context, user);
        break;
      case 'notify':
        _sendNotification(context, user);
        break;
    }
  }

  void _showUserDetails(BuildContext context, Map user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user['name']),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Email:', user['email']),
              _buildDetailRow('Phone:', user['phone']),
              _buildDetailRow('Location:', user['location']),
              _buildDetailRow('Status:', user['status']),
              _buildDetailRow('Joined:', user['joined']),
              _buildDetailRow('Unpaid Bills:', user['unpaidBills']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
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

  void _confirmDeactivate(BuildContext context, Map user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Deactivate User'),
        content: Text('Are you sure you want to deactivate ${user['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${user['name']} deactivated')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Deactivate'),
          ),
        ],
      ),
    );
  }

  void _sendNotification(BuildContext context, Map user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Send Notification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
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
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notification sent to ${user['name']}')),
              );
            },
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}

// ==================== ADMIN PICKUP REQUESTS SCREEN ====================
class AdminPickupRequestsScreen extends StatefulWidget {
  @override
  State<AdminPickupRequestsScreen> createState() =>
      _AdminPickupRequestsScreenState();
}

class _AdminPickupRequestsScreenState extends State<AdminPickupRequestsScreen> {
  final List<Map<String, dynamic>> pickupRequests = [
    {
      'id': 'PK001',
      'user': 'Ineza Marie',
      'location': 'Nyarugenge, Kigali',
      'date': '2024-12-10',
      'time': '9:00 AM',
      'status': 'Pending',
      'type': 'Regular Waste',
    },
    {
      'id': 'PK002',
      'user': 'Uwase Jean',
      'location': 'Gasabo, Kigali',
      'date': '2024-12-10',
      'time': '10:30 AM',
      'status': 'Pending',
      'type': 'Recyclable',
    },
    {
      'id': 'PK003',
      'user': 'Mutoni Alice',
      'location': 'Kicukiro, Kigali',
      'date': '2024-12-11',
      'time': '8:00 AM',
      'status': 'Confirmed',
      'type': 'Bulk Waste',
    },
    {
      'id': 'PK004',
      'user': 'Imena Patrick',
      'location': 'Nyarugenge, Kigali',
      'date': '2024-12-09',
      'time': '2:00 PM',
      'status': 'Completed',
      'type': 'Regular Waste',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Pickup Requests'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: pickupRequests.length,
        itemBuilder: (context, index) {
          final request = pickupRequests[index];
          Color statusColor = request['status'] == 'Pending'
              ? Colors.orange
              : request['status'] == 'Confirmed'
                  ? Colors.blue
                  : Colors.green;

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
                        request['id'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                  _buildInfoRow(Icons.person, 'User:', request['user']),
                  _buildInfoRow(Icons.location_on, 'Location:', request['location']),
                  _buildInfoRow(Icons.calendar_today, 'Date:', request['date']),
                  _buildInfoRow(Icons.access_time, 'Time:', request['time']),
                  _buildInfoRow(Icons.delete, 'Type:', request['type']),
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
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
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

  void _confirmPickup(BuildContext context, Map request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Pickup'),
        content: Text('Confirm pickup request ${request['id']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                request['status'] = 'Confirmed';
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Pickup ${request['id']} confirmed'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _rejectPickup(BuildContext context, Map request) {
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
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Pickup ${request['id']} rejected'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Reject'),
          ),
        ],
      ),
    );
  }

  void _markCompleted(BuildContext context, Map request) {
    setState(() {
      request['status'] = 'Completed';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pickup ${request['id']} marked as completed'),
        backgroundColor: Colors.green,
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
        _buildMetricCard(
          'New Users',
          '45',
          '+12% from yesterday',
          Colors.blue,
          Icons.person_add,
        ),
        _buildMetricCard(
          'Pickups Completed',
          '128',
          '+8% from yesterday',
          Colors.green,
          Icons.check_circle,
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
        _buildPerformanceIndicator('Payment Collection', 0.78, Colors.orange),
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
'New support ticket: Billing Issue',
'15 minutes ago',
Icons.support_agent,
Colors.orange,
),
_buildNotification(
'Payment received: Rs. 500',
'1 hour ago',
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
),
);
}
}