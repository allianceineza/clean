import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'More Settings',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 25),

                // Settings List
                _buildSettingItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Settings',
                  onTap: () => _openPrivacySettings(context),
                ),
                _buildSettingItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notification Settings',
                  onTap: () => _openNotificationSettings(context),
                ),
                _buildSettingItem(
                  icon: Icons.payment_outlined,
                  title: 'Payment Methods',
                  onTap: () => _openPaymentMethods(context),
                ),
                _buildSettingItem(
                  icon: Icons.language_outlined,
                  title: 'Language Settings',
                  onTap: () => _openLanguageSettings(context),
                ),
                _buildSettingItem(
                  icon: Icons.storage_outlined,
                  title: 'Data Settings',
                  onTap: () => _openDataSettings(context),
                ),
                _buildSettingItem(
                  icon: Icons.gavel_outlined,
                  title: 'Legal Information',
                  onTap: () => _openLegalInformation(context),
                ),
                _buildSettingItem(
                  icon: Icons.help_outline,
                  title: 'FAQs',
                  onTap: () => _openFAQs(context),
                ),

                const SizedBox(height: 10),

                // App Version
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.grey[600]),
                          const SizedBox(width: 15),
                          Text(
                            'App Version',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '1.0.1',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Additional Options
                _buildActionButton(
                  icon: Icons.logout,
                  title: 'Logout',
                  color: Colors.red,
                  onTap: () => _showLogoutDialog(context),
                ),
                const SizedBox(height: 10),
                _buildActionButton(
                  icon: Icons.delete_outline,
                  title: 'Delete Account',
                  color: Colors.red[700]!,
                  onTap: () => _showDeleteAccountDialog(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        onTap: onTap,
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Privacy Settings
  void _openPrivacySettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrivacySettingsScreen(),
      ),
    );
  }

  // Notification Settings
  void _openNotificationSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationSettingsScreen(),
      ),
    );
  }

  // Payment Methods
  void _openPaymentMethods(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentMethodsScreen(),
      ),
    );
  }

  // Language Settings
  void _openLanguageSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LanguageSettingsScreen(),
      ),
    );
  }

  // Data Settings
  void _openDataSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DataSettingsScreen(),
      ),
    );
  }

  // Legal Information
  void _openLegalInformation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LegalInformationScreen(),
      ),
    );
  }

  // FAQs
  void _openFAQs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FAQsScreen(),
      ),
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

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            const SizedBox(width: 10),
            Text('Delete Account'),
          ],
        ),
        content: Text(
          'This action is irreversible. All your data will be permanently deleted. Are you sure?',
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
                  content: Text('Account deletion initiated'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// Privacy Settings Screen
class PrivacySettingsScreen extends StatefulWidget {
  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool shareDataWithPartners = false;
  bool allowAnalytics = true;
  bool showProfilePublicly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Settings'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SwitchListTile(
            title: Text('Share Data with Partners'),
            subtitle: Text('Allow sharing anonymized data'),
            value: shareDataWithPartners,
            activeColor: Colors.teal,
            onChanged: (value) {
              setState(() {
                shareDataWithPartners = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Analytics'),
            subtitle: Text('Help improve the app'),
            value: allowAnalytics,
            activeColor: Colors.teal,
            onChanged: (value) {
              setState(() {
                allowAnalytics = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Public Profile'),
            subtitle: Text('Make profile visible to others'),
            value: showProfilePublicly,
            activeColor: Colors.teal,
            onChanged: (value) {
              setState(() {
                showProfilePublicly = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

// Notification Settings Screen
class NotificationSettingsScreen extends StatefulWidget {
  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool pickupReminders = true;
  bool billReminders = true;
  bool promotionalNotifications = false;
  bool eventNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SwitchListTile(
            title: Text('Pickup Reminders'),
            subtitle: Text('Get notified before scheduled pickups'),
            value: pickupReminders,
            activeColor: Colors.teal,
            onChanged: (value) {
              setState(() {
                pickupReminders = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Bill Reminders'),
            subtitle: Text('Payment due date notifications'),
            value: billReminders,
            activeColor: Colors.teal,
            onChanged: (value) {
              setState(() {
                billReminders = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Promotional Notifications'),
            subtitle: Text('Offers and discounts'),
            value: promotionalNotifications,
            activeColor: Colors.teal,
            onChanged: (value) {
              setState(() {
                promotionalNotifications = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Event Notifications'),
            subtitle: Text('Upcoming community events'),
            value: eventNotifications,
            activeColor: Colors.teal,
            onChanged: (value) {
              setState(() {
                eventNotifications = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

// Payment Methods Screen
class PaymentMethodsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildPaymentMethodCard(
            icon: Icons.phone_android,
            title: 'Mobile Money',
            subtitle: '**** **** 3456',
            isDefault: true,
          ),
          _buildPaymentMethodCard(
            icon: Icons.credit_card,
            title: 'Credit Card',
            subtitle: '**** **** **** 1234',
            isDefault: false,
          ),
          _buildPaymentMethodCard(
            icon: Icons.account_balance,
            title: 'Bank Transfer',
            subtitle: 'Bank of Kigali',
            isDefault: false,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Add new payment method')),
              );
            },
            icon: Icon(Icons.add),
            label: Text('Add Payment Method'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDefault,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal.withOpacity(0.1),
          child: Icon(icon, color: Colors.teal),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: isDefault
            ? Chip(
                label: Text('Default', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.green,
                labelStyle: TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }
}

// Language Settings Screen
class LanguageSettingsScreen extends StatefulWidget {
  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Settings'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildLanguageOption('English'),
          _buildLanguageOption('Kinyarwanda'),
          _buildLanguageOption('French'),
          _buildLanguageOption('Swahili'),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    return RadioListTile<String>(
      title: Text(language),
      value: language,
      groupValue: selectedLanguage,
      activeColor: Colors.teal,
      onChanged: (value) {
        setState(() {
          selectedLanguage = value!;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Language changed to $value')),
        );
      },
    );
  }
}

// Data Settings Screen
class DataSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Settings'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ListTile(
            leading: Icon(Icons.download, color: Colors.teal),
            title: Text('Download My Data'),
            subtitle: Text('Get a copy of your data'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Preparing data download...')),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.delete_sweep, color: Colors.orange),
            title: Text('Clear Cache'),
            subtitle: Text('Free up storage space'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Cache cleared successfully')),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.sync, color: Colors.blue),
            title: Text('Sync Data'),
            subtitle: Text('Sync with cloud'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Syncing data...')),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Legal Information Screen
class LegalInformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legal Information'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ListTile(
            leading: Icon(Icons.description, color: Colors.teal),
            title: Text('Terms of Service'),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showLegalDocument(context, 'Terms of Service'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.teal),
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showLegalDocument(context, 'Privacy Policy'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.gavel, color: Colors.teal),
            title: Text('License Agreement'),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showLegalDocument(context, 'License Agreement'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info, color: Colors.teal),
            title: Text('About CleanRoute'),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  void _showLegalDocument(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(
            'This is a placeholder for the $title document. '
            'In a production app, this would contain the full legal text.',
            style: TextStyle(height: 1.5),
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

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'CleanRoute',
      applicationVersion: '1.0.1',
      applicationIcon: Icon(Icons.eco, size: 48, color: Colors.teal),
      children: [
        Text('Your eco-friendly waste management solution.'),
        SizedBox(height: 10),
        Text('© 2024 CleanRoute Tech. All rights reserved.'),
      ],
    );
  }
}

// FAQs Screen
class FAQsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildFAQItem(
            'How do I change my pickup schedule?',
            'Go to the Schedule tab and tap on any day to modify your pickup time.',
          ),
          _buildFAQItem(
            'What payment methods are accepted?',
            'We accept mobile money, credit cards, and bank transfers.',
          ),
          _buildFAQItem(
            'How can I track my recycling impact?',
            'Check the home screen to see the number of trees planted based on your recycling efforts.',
          ),
          _buildFAQItem(
            'What if I miss a pickup?',
            'Contact support immediately through the Support tab to reschedule.',
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              answer,
              style: TextStyle(height: 1.5, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}