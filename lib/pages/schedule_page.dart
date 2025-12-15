import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String selectedLocation = 'Nyarugenge, Kigali';
  int selectedDayIndex = -1;
  DateTime currentMonth = DateTime.now();

  List<Map<String, dynamic>> _generateScheduleData() {
    List<Map<String, dynamic>> scheduleList = [];
    DateTime now = DateTime.now();
    DateTime startDate = DateTime(currentMonth.year, currentMonth.month, 1);
    
    // Generate schedule for current week (7 days from today)
    for (int i = 0; i < 9; i++) {
      DateTime date = now.add(Duration(days: i));
      
      // Randomly assign active status (you can customize this logic)
      bool isActive = (i >= 3); // Days 4-9 are scheduled
      
      // Vary pickup times
      String time = _getPickupTime(date.weekday);
      
      scheduleList.add({
        'day': DateFormat('EEEE').format(date),
        'date': DateFormat('dd').format(date),
        'time': time,
        'isActive': isActive,
        'fullDate': date,
      });
    }
    
    return scheduleList;
  }

  String _getPickupTime(int weekday) {
    // Different times for different days
    switch (weekday) {
      case DateTime.monday:
        return '6:00 AM';
      case DateTime.tuesday:
        return '5:30 AM';
      case DateTime.wednesday:
        return '6:00 AM';
      case DateTime.thursday:
        return '5:00 AM';
      case DateTime.friday:
        return '5:30 AM';
      case DateTime.saturday:
        return '6:00 AM';
      case DateTime.sunday:
        return '5:00 AM';
      default:
        return '6:00 AM';
    }
  }

  String _getMonthDisplay() {
    DateTime now = DateTime.now();
    DateTime endDate = now.add(Duration(days: 8));
    
    String startDay = DateFormat('dd').format(now);
    String endDay = DateFormat('dd').format(endDate);
    
    return '$startDay-$endDay';
  }

  @override
  Widget build(BuildContext context) {
    final scheduleData = _generateScheduleData();
    final currentMonthName = DateFormat('MMMM').format(currentMonth).toUpperCase();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Schedule',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.teal),
            onPressed: _showMonthPicker,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Your Location:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(width: 5),
                        Text(
                          selectedLocation,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _showLocationDialog,
                      child: Text(
                        'Change Location',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Month Header with Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.chevron_left, color: Colors.teal),
                        onPressed: () {
                          setState(() {
                            currentMonth = DateTime(
                              currentMonth.year,
                              currentMonth.month - 1,
                            );
                          });
                        },
                      ),
                      Text(
                        currentMonthName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 1.5,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right, color: Colors.teal),
                        onPressed: () {
                          setState(() {
                            currentMonth = DateTime(
                              currentMonth.year,
                              currentMonth.month + 1,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    _getMonthDisplay(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Schedule List
              ...scheduleData.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> schedule = entry.value;
                return _buildScheduleItem(
                  schedule['date'],
                  schedule['day'],
                  schedule['time'],
                  schedule['isActive'],
                  schedule['fullDate'],
                  index,
                );
              }).toList(),

              const SizedBox(height: 20),

              // Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Schedules are updated automatically. Tap any day to view or modify pickup details.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleItem(
    String date,
    String day,
    String time,
    bool isActive,
    DateTime fullDate,
    int index,
  ) {
    bool isSelected = selectedDayIndex == index;
    bool isToday = DateFormat('dd').format(DateTime.now()) == date &&
        fullDate.month == DateTime.now().month;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDayIndex = index;
        });
        _showScheduleDetailsDialog(date, day, time, isActive, fullDate);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.teal.withOpacity(0.1)
              : isToday
                  ? Colors.amber.withOpacity(0.1)
                  : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Colors.teal
                : isToday
                    ? Colors.amber
                    : Colors.grey[200]!,
            width: isSelected || isToday ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Date Circle
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: isToday
                    ? Colors.amber.withOpacity(0.2)
                    : isActive
                        ? Colors.teal.withOpacity(0.1)
                        : Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isToday
                        ? Colors.amber[900]
                        : isActive
                            ? Colors.teal
                            : Colors.grey[600],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),

            // Day and Time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        day,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      if (isToday) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'TODAY',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Status Indicator
            Container(
              width: 6,
              height: 45,
              decoration: BoxDecoration(
                color: isActive ? Colors.teal : Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationDialog() {
    final locations = [
      'Nyarugenge, Kigali',
      'Gasabo, Kigali',
      'Kicukiro, Kigali',
      'Musanze, Northern Province',
      'Rubavu, Western Province',
      'Huye, Southern Province',
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Location'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: locations.map((location) {
            return RadioListTile<String>(
              title: Text(location),
              value: location,
              groupValue: selectedLocation,
              activeColor: Colors.teal,
              onChanged: (value) {
                setState(() {
                  selectedLocation = value!;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showMonthPicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentMonth,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.teal,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        currentMonth = picked;
      });
    }
  }

  void _showScheduleDetailsDialog(
      String date, String day, String time, bool isActive, DateTime fullDate) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isActive ? Icons.check_circle : Icons.info,
              color: isActive ? Colors.green : Colors.orange,
            ),
            const SizedBox(width: 10),
            Text('Schedule Details'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
                'Date:', DateFormat('MMMM dd, yyyy').format(fullDate)),
            const SizedBox(height: 10),
            _buildDetailRow('Day:', day),
            const SizedBox(height: 10),
            _buildDetailRow('Time:', time),
            const SizedBox(height: 10),
            _buildDetailRow('Location:', selectedLocation),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Status: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isActive ? 'Scheduled' : 'Not Scheduled',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
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
          if (!isActive)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Pickup scheduled for $day at $time'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: Text('Schedule Pickup'),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}