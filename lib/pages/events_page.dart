import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Back + Title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Events",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

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
                  children: const [
                    Icon(Icons.location_on_outlined, color: Colors.black54),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Nyarugenge, Kiyovu",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: TextButton(
                  onPressed: () {},
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
                        value: "July",
                        items: const [
                          DropdownMenuItem(value: "July", child: Text("July")),
                          DropdownMenuItem(value: "August", child: Text("August")),
                          DropdownMenuItem(value: "September", child: Text("September")),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Expanded ListView of Events
              Expanded(
                child: ListView(
                  children: [
                    eventCard("02", "Temple Cleaning Program",
                        "Thu, 8 am .44621 Gasabo, Kacyiru"),
                    eventCard("04", "Afforestation Program",
                        "Sat, 11 am .Nyarugenge, Gitega"),
                    eventCard("11", "Street Cleanup",
                        "Sun, 9 am .Gasabo, Remera"),
                    eventCard("16", "Public Gardening Project",
                        "Wed, 10 am .Nyarugenge, Norvage"),
                    eventCard("24", "Street Art Workshop",
                        "Fri, 2 pm .Nyarugenge, Nyamirambo"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────
  // Event Card Widget
  // ───────────────────────────────
  Widget eventCard(String date, String title, String subtitle) {
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
      child: Row(
        children: [
          // Date Square
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade100,
            ),
            child: Center(
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
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
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // RSVP Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0B8A6E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "RSVP",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
