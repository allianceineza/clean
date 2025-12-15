import 'package:flutter/material.dart';
import '../widgets/bill_card.dart';
import '../widgets/tree_card.dart';
import '../widgets/action_button.dart';
import '../services/auth_service.dart'; // Correct import
import 'authentication.dart'; 
import 'register.dart';
import 'signin.dart';

class HomeScreen extends StatelessWidget {
  final Function(int)? onTabChange;

  const HomeScreen({Key? key, this.onTabChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CleanRoute Tech 🔔',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showProfileMenu(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Bill Card
              const BillCard(),
              const SizedBox(height: 25),
              
              // Action Buttons in a scrollable row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ActionButton(
                      icon: Icons.schedule,
                      label: 'Schedule',
                      color: Colors.blue,
                      onPressed: () => Navigator.pushNamed(context, '/schedule'),
                    ),
                    const SizedBox(width: 15),
                    ActionButton(
                      icon: Icons.recycling,
                      label: 'Recycle',
                      color: Colors.teal,
                      onPressed: () => Navigator.pushNamed(context, '/recycle'),
                    ),
                    const SizedBox(width: 15),
                    ActionButton(
                      icon: Icons.event,
                      label: 'Events',
                      color: Colors.purple,
                      onPressed: () => Navigator.pushNamed(context, '/events'),
                    ),
                    const SizedBox(width: 15),
                    ActionButton(
                      icon: Icons.lightbulb_outline,
                      label: 'Tips',
                      color: Colors.amber,
                      onPressed: () => Navigator.pushNamed(context, '/tips'),
                    ),
                    const SizedBox(width: 15),
                    ActionButton(
                      icon: Icons.article_outlined,
                      label: 'Blog',
                      color: Colors.cyan,
                      onPressed: () => Navigator.pushNamed(context, '/blog'),
                    ),
                    const SizedBox(width: 15),
                    ActionButton(
                      icon: Icons.volunteer_activism,
                      label: 'Donate',
                      color: Colors.purple,
                      onPressed: () => Navigator.pushNamed(context, '/donate'),
                    ),
                  ],
                ),
              ),

              // Tree Card
              const TreeCard(),
            ],
          ),
        ),
      ),
    );
  }

  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // Check if user is logged in
        bool isLoggedIn = AuthService.isLoggedIn;
        
        if (isLoggedIn) {
          // Show profile options for logged-in users
          return _buildLoggedInMenu(context);
        } else {
          // Show login/register options
          return _buildAuthMenu(context);
        }
      },
    );
  }

  Widget _buildAuthMenu(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Icon
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.teal.withOpacity(0.1),
            child: Icon(Icons.person, size: 50, color: Colors.teal),
          ),
          const SizedBox(height: 20),
          
          Text(
            'Welcome to CleanRoute!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Sign in to access all features',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 30),
          
          // Sign In Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to Sign In screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2C5F6F),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Register Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to Register screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Color(0xFF2C5F6F),
                side: BorderSide(color: Color(0xFF2C5F6F)),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildLoggedInMenu(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Profile Header
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.teal,
                child: Icon(Icons.person, size: 35, color: Colors.white),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AuthService.currentUserEmail ?? 'User',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'View Profile',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          
          // Menu Items
          _buildMenuItem(
            context,
            icon: Icons.person,
            title: 'My Profile',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Profile page coming soon')),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.history,
            title: 'Pickup History',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('History page coming soon')),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Settings page coming soon')),
              );
            },
          ),
          Divider(),
          _buildMenuItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            color: Colors.red,
            onTap: () {
              Navigator.pop(context);
              _showLogoutDialog(context);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.teal),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.logout, color: Colors.orange),
            const SizedBox(width: 10),
            Text('Logout'),
          ],
        ),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              AuthService.logout();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: Colors.green,
                ),
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