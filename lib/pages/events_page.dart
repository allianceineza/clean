import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import '../services/auth_service.dart';
import '../screens/signin.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<Map<String, dynamic>> _events = [];
  bool _isLoading = true;
  String _selectedMonth = "All";
  final List<String> _months = [
    "All",
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      final events = await DatabaseService.instance.getEvents();
      // Filter by month if not "All"
      List<Map<String, dynamic>> filteredEvents = events;
      if (_selectedMonth != "All") {
        filteredEvents = events.where((event) {
          final date = DateTime.parse(event['date']);
          final monthNames = [
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
          ];
          return monthNames[date.month - 1] == _selectedMonth;
        }).toList();
      }
      setState(() {
        _events = filteredEvents;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading events: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isLoggedIn() {
    return AuthService.isLoggedIn;
  }

  bool _isAdmin() {
    return AuthService.isAdmin();
  }

  // Show login required dialog
  void _showLoginRequiredDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Icon(Icons.lock_outline, color: Colors.orange, size: 60),
        title: Text(
          'Login Required',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'You need to be logged in to create events.\n\nPlease sign in to continue.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ),
              ).then((_) {
                // Refresh state after returning from sign in
                setState(() {});
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2C5F6F),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'Sign In',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Method to show create event form
  void _showCreateEventDialog(BuildContext context) {
    // Check if user is logged in
    if (!_isLoggedIn()) {
      _showLoginRequiredDialog();
      return;
    }

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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Row(
                children: [
                  Icon(Icons.event, color: Colors.teal),
                  SizedBox(width: 10),
                  Text('Create New Event'),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Event Title *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter event title',
                        prefixIcon: Icon(Icons.title),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _descController,
                      decoration: InputDecoration(
                        labelText: 'Description *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter event description',
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter event location',
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _timeController,
                      decoration: InputDecoration(
                        labelText: 'Time *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'e.g., 2:00 PM',
                        prefixIcon: Icon(Icons.access_time),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: Icon(Icons.calendar_today),
                      label: Text(
                        'Select Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      ),
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
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _titleController.dispose();
                    _descController.dispose();
                    _locationController.dispose();
                    _timeController.dispose();
                    Navigator.pop(context);
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.grey)),
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
                        'organizer': AuthService.getCurrentUserName(),
                        'category': 'community',
                        'participants': 0,
                        'rsvps': [],
                      });

                      _titleController.dispose();
                      _descController.dispose();
                      _locationController.dispose();
                      _timeController.dispose();
                      
                      Navigator.pop(context);
                      _loadEvents(); // Refresh events
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 8),
                              Text('Event created successfully!'),
                            ],
                          ),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } catch (e) {
                      print('Error creating event: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error creating event: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCreateEventDialog(context);
        },
        backgroundColor: Colors.teal,
        icon: Icon(Icons.add),
        label: Text('Create Event'),
        tooltip: 'Create New Event',
      ),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar Section
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Events",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (_isLoggedIn())
                        Text(
                          'Hi, ${AuthService.getCurrentUserName()}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.add_circle, color: Colors.teal, size: 28),
                    onPressed: () {
                      _showCreateEventDialog(context);
                    },
                    tooltip: 'Create Event',
                  ),
                ],
              ),
            ),
            
            // Content Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    // Location Section
                    const Text(
                      "Your Location:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.teal),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              AuthService.getUserLocation(),
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Location change feature coming soon!'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        },
                        child: const Text(
                          "Change Location",
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // All Events + Month Dropdown
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "All Events:",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                            color: Colors.white,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedMonth,
                              items: _months.map((month) {
                                return DropdownMenuItem(
                                  value: month,
                                  child: Text(month),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedMonth = value;
                                    _isLoading = true;
                                  });
                                  _loadEvents();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // Events List
                    Expanded(
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : _events.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.event_note, size: 64, color: Colors.grey[400]),
                                      SizedBox(height: 16),
                                      Text(
                                        'No events found',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      if (_selectedMonth != "All")
                                        Text(
                                          'for $_selectedMonth',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      SizedBox(height: 20),
                                      ElevatedButton.icon(
                                        icon: Icon(Icons.add),
                                        label: Text('Create Your First Event'),
                                        onPressed: () {
                                          _showCreateEventDialog(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal,
                                          foregroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 24,
                                            vertical: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : RefreshIndicator(
                                  onRefresh: _loadEvents,
                                  child: ListView.builder(
                                    itemCount: _events.length,
                                    itemBuilder: (context, index) {
                                      final event = _events[index];
                                      return _buildEventCard(event);
                                    },
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    final date = DateTime.parse(event['date']);
    final day = date.day.toString();
    final weekday = _getWeekday(date.weekday);
    final month = _getMonthName(date.month);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Date Square
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.teal.withOpacity(0.1),
                  border: Border.all(color: Colors.teal),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.teal,
                        ),
                      ),
                      Text(
                        month.substring(0, 3),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 15),

              // Title + Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['title'] ?? 'Untitled Event',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$weekday, ${event['time'] ?? 'TBD'} • ${event['location'] ?? 'Location TBD'}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    if (event['organizer'] != null)
                      Text(
                        'By ${event['organizer']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Description
          if (event['description'] != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                event['description']!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          
          // Participants and RSVP Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.people_outline, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    '${event['participants'] ?? 0} attending',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              
              ElevatedButton(
                onPressed: () async {
                  if (!_isLoggedIn()) {
                    _showLoginRequiredDialog();
                    return;
                  }

                  try {
                    final currentUser = AuthService.currentUser;
                    if (currentUser != null) {
                      await DatabaseService.instance.rsvpToEvent(
                        event['id'],
                        currentUser['id'] ?? 1,
                        currentUser['firstName'] ?? 'User',
                      );
                      
                      // Refresh events
                      _loadEvents();
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 8),
                              Text('You\'ve RSVP\'d to this event!'),
                            ],
                          ),
                          backgroundColor: Colors.teal,
                        ),
                      );
                    }
                  } catch (e) {
                    print('Error RSVPing: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error RSVPing: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B8A6E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  "RSVP",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getWeekday(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}