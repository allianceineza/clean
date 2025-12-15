import 'package:flutter/material.dart';
import 'recyclingtips.dart';

class RecyclePage extends StatefulWidget {
  const RecyclePage({Key? key}) : super(key: key);

  @override
  State<RecyclePage> createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {
  final Map<String, int> items = {
    "Paper": 0,
    "Bottle": 0,
    "Metal": 0,
    "Cardboard": 0,
  };

  void _calculate() {
    int total = items.values.fold(0, (a, b) => a + b);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Calculation Result"),
        content: Text("You have a total of **$total** recyclable items."),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  void _requestPickup() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Pickup Requested"),
        content: const Text(
          "Your recycling pickup request has been sent! "
          "A team member will contact you shortly.",
        ),
        actions: [
          TextButton(
            child: const Text("Great!"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Recycle",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...items.keys.map((item) => _buildRecycleItem(item)).toList(),

            const SizedBox(height: 20),

            // Calculate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _calculate,
                child: const Text(
                  "Calculate",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Request Pickup Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _requestPickup,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Request a Pickup  "),
                    Icon(Icons.local_shipping_outlined),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tips Button
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RecyclingTipsPage()),
                );
              },
              child: const Text(
                "View Recycling Tips",
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRecycleItem(String item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(
        children: [
          Icon(
            item == "Paper"
                ? Icons.article
                : item == "Bottle"
                    ? Icons.local_drink
                    : item == "Metal"
                        ? Icons.circle
                        : Icons.inventory,
            color: Colors.teal,
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Text(
              item,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () {
              setState(() {
                if (items[item]! > 0) items[item] = items[item]! - 1;
              });
            },
          ),

          Text(
            items[item]!.toString().padLeft(2, "0"),
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),

          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              setState(() {
                items[item] = items[item]! + 1;
              });
            },
          ),
        ],
      ),
    );
  }
}
