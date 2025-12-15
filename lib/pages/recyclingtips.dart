import 'package:flutter/material.dart';

class RecyclingTipsPage extends StatelessWidget {
  const RecyclingTipsPage({Key? key}) : super(key: key);

  final List<String> tips = const [
    "Clean containers before recycling to remove food residue.",
    "Separate lids and caps from their containers.",
    "Check recycling symbols to know which plastics are accepted.",
    "Flatten cardboard boxes to save space.",
    "Avoid recycling greasy or food-soiled items.",
    "Reuse jars, containers, and bags whenever possible.",
    "Take electronics to proper e-waste centers.",
    "Don't recycle unknown items (avoid wish-cycling)."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Recycling Tips",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "assets/recycle_banner.jpg",
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Helpful Recycling Tips",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),

          const SizedBox(height: 12),

          ...List.generate(tips.length, (index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.teal.withOpacity(0.15),
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(color: Colors.teal),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tips[index],
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
