import 'package:flutter/material.dart';
import 'recyclingtips.dart';
import '../database/database_helper.dart';
import '../services/database_helper.dart' as db_service;

class RecyclePage extends StatefulWidget {
  const RecyclePage({Key? key}) : super(key: key);

  @override
  State<RecyclePage> createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {
  // Updated categories to match your UI
  final Map<String, int> items = {
    "Glass": 0,
    "Metal": 0,
    "Cardboard": 0,
    "Electronics": 0,
    "Paper": 0,
    "Plastic Bottles": 0,
  };

  // Item icons and colors
  final Map<String, IconData> itemIcons = {
    "Glass": Icons.wine_bar,
    "Metal": Icons.build,
    "Cardboard": Icons.inventory_2,
    "Electronics": Icons.devices,
    "Paper": Icons.description,
    "Plastic Bottles": Icons.local_drink,
  };

  final Map<String, Color> itemColors = {
    "Glass": Colors.amber,
    "Metal": Colors.grey,
    "Cardboard": Colors.brown,
    "Electronics": Colors.purple,
    "Paper": Colors.blue,
    "Plastic Bottles": Colors.green,
  };

  // Controllers for pickup request
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadItemCountsFromDatabase();
  }

  @override
  void dispose() {
    _locationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    // Save counts before disposing
    _saveAllCountsToDatabase();
    super.dispose();
  }

  // Load counts from database
  void _loadItemCountsFromDatabase() {
    final counts = DatabaseHelper.getAllItemCounts();
    setState(() {
      for (final category in items.keys) {
        items[category] = counts[category] ?? 0;
      }
    });
  }

  // Save all counts to database
  void _saveAllCountsToDatabase() {
    for (final entry in items.entries) {
      DatabaseHelper.updateItemCount(entry.key, entry.value);
    }
  }

  // Update single count in database and UI
  void _updateItemCount(String category, int newCount) {
    setState(() {
      items[category] = newCount;
    });
    DatabaseHelper.updateItemCount(category, newCount);
  }

  void _calculate() {
    int total = DatabaseHelper.getTotalItems();
    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.calculate, color: Colors.teal),
            SizedBox(width: 10),
            Text("Calculation Result"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Items: $total",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Breakdown:"),
            ...items.entries
                .where((entry) => entry.value > 0)
                .map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Icon(itemIcons[entry.key], 
                              color: itemColors[entry.key], size: 16),
                          const SizedBox(width: 8),
                          Text("${entry.key}: ${entry.value}"),
                        ],
                      ),
                    ))
                .toList(),
            if (total == 0)
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "No items added yet!",
                  style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  void _requestPickup() async {
    int total = DatabaseHelper.getTotalItems();
    
    if (total == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please add at least one item before requesting pickup'),
          backgroundColor: Colors.orange[800],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.local_shipping, color: Colors.teal),
            SizedBox(width: 10),
            Text("Request Pickup"),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Current items summary
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Items to Pickup:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: items.entries
                          .where((entry) => entry.value > 0)
                          .map((entry) => Chip(
                                backgroundColor: itemColors[entry.key]?.withOpacity(0.2),
                                label: Text("${entry.key} (${entry.value})"),
                                avatar: Icon(itemIcons[entry.key], 
                                    size: 16, color: itemColors[entry.key]),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Pickup Location',
                  hintText: 'Enter your full address',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.location_on),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Pickup Date',
                  hintText: 'Select a date',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.calendar_today),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  );
                  if (pickedDate != null) {
                    _dateController.text = 
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                  }
                },
                readOnly: true,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Pickup Time',
                  hintText: 'Select preferred time',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.access_time),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          alwaysUse24HourFormat: false,
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedTime != null) {
                    final period = pickedTime.period == DayPeriod.am ? 'AM' : 'PM';
                    final hour = pickedTime.hourOfPeriod == 0 ? 12 : pickedTime.hourOfPeriod;
                    _timeController.text = 
                        "${hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')} $period";
                  }
                },
                readOnly: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _locationController.clear();
              _dateController.clear();
              _timeController.clear();
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () async {
              if (_locationController.text.isEmpty ||
                  _dateController.text.isEmpty ||
                  _timeController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Please fill all fields'),
                    backgroundColor: Colors.red[800],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                );
                return;
              }

              Navigator.pop(context);
              await _submitPickupRequest();
            },
            child: const Text("Schedule Pickup"),
          ),
        ],
      ),
    );
  }

  Future<void> _submitPickupRequest() async {
    try {
      final userId = 2; // Use actual user ID from your auth system
      
      // Calculate totals
      int total = DatabaseHelper.getTotalItems();
      
      // Create items breakdown string
      String itemsBreakdown = items.entries
          .where((entry) => entry.value > 0)
          .map((entry) => "${entry.key}: ${entry.value}")
          .join(", ");
      
      // Prepare pickup data
      final pickupData = {
        'userId': userId,
        'location': _locationController.text,
        'date': _dateController.text,
        'time': _timeController.text,
        'type': itemsBreakdown.isEmpty ? 'General Waste' : itemsBreakdown,
        'status': 'Pending',
        'totalItems': total,
        'itemsBreakdown': itemsBreakdown,
      };
      
      // Save to database
      await db_service.DatabaseService.instance.createPickupRequest(pickupData);
      
      // Clear and reset
      _locationController.clear();
      _dateController.clear();
      _timeController.clear();
      
      // Reset all counts in database and UI
      DatabaseHelper.resetAllCounts();
      _loadItemCountsFromDatabase();
      
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            icon: const Icon(Icons.check_circle, color: Colors.green, size: 60),
            title: const Text(
              "Pickup Scheduled!",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              "✅ Your recycling pickup has been scheduled successfully!\n\n"
              "📦 Total items: $total\n"
              "🗑️ Items: ${itemsBreakdown.isEmpty ? 'General Waste' : itemsBreakdown}\n"
              "📍 Location: ${_locationController.text}\n"
              "📅 Date: ${_dateController.text} at ${_timeController.text}\n\n"
              "👨‍💼 The admin has been notified and will review your request.\n"
              "You can track status in your profile.",
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: const Size(120, 45),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Done"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error scheduling pickup: ${e.toString()}'),
            backgroundColor: Colors.red[800],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  void _resetAllItems() {
    DatabaseHelper.resetAllCounts();
    _loadItemCountsFromDatabase(); // Refresh UI from database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('All items reset to zero'),
        backgroundColor: Colors.grey[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalItems = DatabaseHelper.getTotalItems();
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Recycle Center",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt, color: Colors.teal),
            onPressed: _resetAllItems,
            tooltip: 'Reset all items',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.teal[700]!, Colors.teal[500]!],
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.recycling, color: Colors.white, size: 40),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Track Your Recycling",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Add items and schedule a pickup",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Items section
                const Text(
                  "Your Recycling Items",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tap + or - to adjust quantities",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),

                // Items grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items.keys.elementAt(index);
                    return _buildRecycleItem(item);
                  },
                ),

                const SizedBox(height: 24),

                // Stats card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Items",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            totalItems.toString(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.calculate, size: 18),
                        label: const Text("Calculate"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        onPressed: _calculate,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Action buttons
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.local_shipping, size: 22),
                        label: const Text(
                          "Schedule Pickup",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        onPressed: _requestPickup,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.lightbulb_outline),
                        label: const Text("Recycling Tips"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.teal,
                          side: const BorderSide(color: Colors.teal),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RecyclingTipsPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecycleItem(String item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: itemColors[item]?.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                itemIcons[item],
                color: itemColors[item],
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${items[item]} items",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 18),
                  onPressed: () {
                    if (items[item]! > 0) {
                      _updateItemCount(item, items[item]! - 1);
                    }
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    padding: const EdgeInsets.all(4),
                    minimumSize: const Size(32, 32),
                  ),
                ),
                Container(
                  width: 32,
                  alignment: Alignment.center,
                  child: Text(
                    items[item]!.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 18),
                  onPressed: () {
                    _updateItemCount(item, items[item]! + 1);
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: itemColors[item]?.withOpacity(0.1),
                    padding: const EdgeInsets.all(4),
                    minimumSize: const Size(32, 32),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}