import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final List<Map<String, dynamic>> complaintHistory = [
    {
      'title': 'Bin Not Collected on Time',
      'subtitle': 'Missed Pickup',
      'date': '2024-12-05',
      'status': 'Resolved',
    },
    {
      'title': 'Damaged Bin',
      'subtitle': 'Reported Damage',
      'date': '2024-11-28',
      'status': 'In Progress',
    },
    {
      'title': 'Late Collection',
      'subtitle': 'Service Delay',
      'date': '2024-11-15',
      'status': 'Resolved',
    },
  ];

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
                  'Support',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 25),

                // Support Agent Card
                Container(
                  padding: const EdgeInsets.all(20),
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
                  child: Row(
                    children: [
                      // Support Agent Illustration
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.support_agent,
                              size: 50,
                              color: Colors.grey[600],
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Text Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.menu, size: 20, color: Colors.grey[600]),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Facing issues? Create a ticket for quick resolution',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[700],
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _showCreateTicketDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2C5F6F),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Create Ticket',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _callSupport,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Color(0xFF2C5F6F),
                          side: BorderSide(color: Color(0xFF2C5F6F)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Call Support',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // Complaint History Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Complaint History',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    Text(
                      '2024',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Complaint History List
                ...complaintHistory.map((complaint) {
                  return _buildComplaintItem(
                    complaint['title'],
                    complaint['subtitle'],
                    complaint['date'],
                    complaint['status'],
                  );
                }).toList(),

                const SizedBox(height: 25),

                // Contact Methods
                Text(
                  'Other Ways to Reach Us',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 15),

                _buildContactMethod(
                  icon: Icons.email,
                  title: 'Email Support',
                  subtitle: 'support@cleanroute.com',
                  color: Colors.blue,
                  onTap: _sendEmail,
                ),
                const SizedBox(height: 10),
                _buildContactMethod(
                  icon: Icons.chat_bubble,
                  title: 'Live Chat',
                  subtitle: 'Chat with our support team',
                  color: Colors.orange,
                  onTap: _openLiveChat,
                ),
                const SizedBox(height: 10),
                _buildContactMethod(
                  icon: Icons.question_answer,
                  title: 'FAQ',
                  subtitle: 'Find answers to common questions',
                  color: Colors.purple,
                  onTap: _openFAQ,
                ),
                const SizedBox(height: 10),
                _buildContactMethod(
                  icon: Icons.message,
                  title: 'SMS Support',
                  subtitle: 'Send us a text message',
                  color: Colors.green,
                  onTap: _sendSMS,
                ),
                const SizedBox(height: 10),
                _buildContactMethod(
                  icon: Icons.language,
                  title: 'WhatsApp',
                  subtitle: 'Chat on WhatsApp',
                  color: Color(0xFF25D366),
                  onTap: _openWhatsApp,
                ),
                const SizedBox(height: 25),

                // Contact Info Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.teal),
                          const SizedBox(width: 10),
                          Text(
                            '+250 786711958',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.teal),
                          const SizedBox(width: 10),
                          Text(
                            'support@cleanroute.com',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.teal),
                          const SizedBox(width: 10),
                          Text(
                            'Mon-Fri: 8AM-6PM',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComplaintItem(
    String title,
    String subtitle,
    String date,
    String status,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        onTap: () {
          _showComplaintDetails(title, subtitle, date, status);
        },
      ),
    );
  }

  Widget _buildContactMethod({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  void _showCreateTicketDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedCategory = 'Missed Pickup';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Create Support Ticket'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: [
                    'Missed Pickup',
                    'Damaged Bin',
                    'Late Collection',
                    'Billing Issue',
                    'Other',
                  ].map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Ticket created successfully! Ticket #${DateTime.now().millisecondsSinceEpoch}'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  // WORKING CALL FUNCTION
  void _callSupport() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+250786711958');
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        _showErrorDialog('Unable to make call. Please dial +250 788 123 456 manually.');
      }
    } catch (e) {
      _showErrorDialog('Unable to make call. Please dial +250 788 123 456 manually.');
    }
  }

  // WORKING EMAIL FUNCTION
  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@cleanroute.com',
      queryParameters: {
        'subject': 'Support Request - CleanRoute',
        'body': 'Hello CleanRoute Support Team,\n\n',
      },
    );
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _showErrorDialog('Unable to open email app. Please email us at support@cleanroute.com');
      }
    } catch (e) {
      _showErrorDialog('Unable to open email app. Please email us at support@cleanroute.com');
    }
  }

  // WORKING SMS FUNCTION
  void _sendSMS() async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: '+250786711958',
      queryParameters: {'body': 'Hi CleanRoute, I need help with: '},
    );
    try {
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        _showErrorDialog('Unable to open SMS app. Please text +250 788 123 456 manually.');
      }
    } catch (e) {
      _showErrorDialog('Unable to open SMS app. Please text +250 788 123 456 manually.');
    }
  }

  // WORKING WHATSAPP FUNCTION
  void _openWhatsApp() async {
    final phoneNumber = '250786711958'; // WhatsApp format (no + or spaces)
    final message = Uri.encodeComponent('Hi CleanRoute, I need support with my account.');
    
    // Try WhatsApp app first
    final Uri whatsappUri = Uri.parse('whatsapp://send?phone=$phoneNumber&text=$message');
    
    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri);
      } else {
        // Fallback to web WhatsApp
        final Uri webWhatsappUri = Uri.parse('https://wa.me/$phoneNumber?text=$message');
        if (await canLaunchUrl(webWhatsappUri)) {
          await launchUrl(webWhatsappUri, mode: LaunchMode.externalApplication);
        } else {
          _showErrorDialog('Unable to open WhatsApp. Please message us on +250 788 123 456');
        }
      }
    } catch (e) {
      _showErrorDialog('Unable to open WhatsApp. Please message us on +250 788 123 456');
    }
  }

  // WORKING LIVE CHAT FUNCTION
  void _openLiveChat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LiveChatScreen()),
    );
  }

  void _openFAQ() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FAQScreen()),
    );
  }

  void _showComplaintDetails(String title, String subtitle, String date, String status) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Complaint Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: $title', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Type: $subtitle'),
            const SizedBox(height: 8),
            Text('Date: $date'),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Status: '),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: status == 'Resolved' ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info, color: Colors.orange),
            const SizedBox(width: 10),
            Text('Information'),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

// LIVE CHAT SCREEN
class LiveChatScreen extends StatefulWidget {
  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello! Welcome to CleanRoute Support. How can I help you today?',
      'isUser': false,
      'time': '10:30 AM',
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': _messageController.text,
        'isUser': true,
        'time': TimeOfDay.now().format(context),
      });
    });

    final userMessage = _messageController.text.toLowerCase();
    _messageController.clear();

    // Auto-reply based on keywords
    Future.delayed(Duration(seconds: 1), () {
      String reply = '';
      
      if (userMessage.contains('bill') || userMessage.contains('payment')) {
        reply = 'I can help you with billing. Your current bill is Rs. 500 for July. Would you like to make a payment?';
      } else if (userMessage.contains('pickup') || userMessage.contains('collection')) {
        reply = 'For pickup schedules, please go to the Schedule tab. Is there a specific issue with your pickup?';
      } else if (userMessage.contains('help') || userMessage.contains('support')) {
        reply = 'I\'m here to help! You can ask about billing, schedules, recycling, or any other concerns.';
      } else {
        reply = 'Thank you for your message. A support agent will respond shortly. Is there anything else I can help you with?';
      }

      setState(() {
        _messages.add({
          'text': reply,
          'isUser': false,
          'time': TimeOfDay.now().format(context),
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.support_agent, color: Colors.teal),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Support Agent', style: TextStyle(fontSize: 16)),
                Text(
                  'Online',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessage(
                  message['text'],
                  message['isUser'],
                  message['time'],
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(String text, bool isUser, String time) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: isUser ? Colors.teal : Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: isUser ? Colors.white70 : Colors.grey[600],
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// FAQ SCREEN
class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildFAQItem(
            'How do I schedule a pickup?',
            'Go to the Schedule tab on the home screen and select your preferred date and time for waste collection.',
          ),
          _buildFAQItem(
            'What items can I recycle?',
            'We accept paper, cardboard, plastic bottles, glass containers, and metal cans. Check the Recycle tab for a complete list.',
          ),
          _buildFAQItem(
            'How do I pay my bill?',
            'Visit the Billing tab and click "Pay Now". You can pay via mobile money, credit card, or bank transfer.',
          ),
          _buildFAQItem(
            'What if my bin is not collected?',
            'Please report missed pickups through the Support tab. We\'ll reschedule your collection within 24 hours.',
          ),
          _buildFAQItem(
            'How can I track my tree planting?',
            'Your tree planting progress is displayed on the home screen. For each ton of waste recycled, we plant one tree.',
          ),
          _buildFAQItem(
            'What are your operating hours?',
            'Our support team is available Monday-Friday, 8AM-6PM. Emergency services are available 24/7.',
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
              style: TextStyle(color: Colors.grey[700], height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}