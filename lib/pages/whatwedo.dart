import 'package:flutter/material.dart';

class WhatWeDoSection extends StatelessWidget {
  const WhatWeDoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero section with image
        Stack(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=800&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
            Container(
              height: 250,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.eco,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Making Recycling Easy",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Your partner in sustainable waste management",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.95),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Service cards with images
        _buildServiceCardWithImage(
          imageUrl:
              'https://images.unsplash.com/photo-1611284446314-60a58ac0deb9?w=600&q=80',
          icon: Icons.recycling,
          iconColor: Colors.green,
          title: "Track Your Recycling",
          description:
              "Easily log and track all your recyclable items including glass, metal, paper, cardboard, electronics, and plastic bottles. Monitor your environmental impact in real-time.",
        ),

        _buildServiceCardWithImage(
          imageUrl:
              'https://images.unsplash.com/photo-1566576721346-d4a3b4eaeb55?w=600&q=80',
          icon: Icons.local_shipping,
          iconColor: Colors.blue,
          title: "Schedule Pickups",
          description:
              "Book convenient pickup times that work for your schedule. Our team will collect your recyclables from your doorstep, making recycling hassle-free.",
        ),

        _buildServiceCardWithImage(
          imageUrl:
              'https://images.unsplash.com/photo-1572459511734-b3cd6e4bc4ab?w=600&q=80',
          icon: Icons.location_on,
          iconColor: Colors.orange,
          title: "Find Recycling Centers",
          description:
              "Discover nearby recycling centers and drop-off locations. Get directions, operating hours, and information about accepted materials.",
        ),

        _buildServiceCardWithImage(
          imageUrl:
              'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=600&q=80',
          icon: Icons.tips_and_updates,
          iconColor: Colors.purple,
          title: "Expert Tips & Guidance",
          description:
              "Learn the best recycling practices with our comprehensive guides. Get tips on proper sorting, cleaning, and preparing materials for recycling.",
        ),

        _buildServiceCardWithImage(
          imageUrl:
              'https://images.unsplash.com/photo-1532629345422-7515f3d16bb6?w=600&q=80',
          icon: Icons.analytics,
          iconColor: Colors.teal,
          title: "Impact Dashboard",
          description:
              "View your recycling statistics and see the positive impact you're making. Track your contribution to reducing waste and protecting the environment.",
        ),

        _buildServiceCardWithImage(
          imageUrl:
              'https://images.unsplash.com/photo-1556912172-45b7abe8b7e1?w=600&q=80',
          icon: Icons.verified_user,
          iconColor: Colors.indigo,
          title: "Secure & Reliable",
          description:
              "Your data is protected with industry-standard security. Count on reliable service with verified pickup partners and transparent tracking.",
        ),

        // Call to action section
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal[600]!, Colors.teal[400]!],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(
                Icons.eco,
                size: 60,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
              const Text(
                "Start Your Journey Today!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Join thousands of users making a difference. Every item recycled counts!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.95),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // change this to navigate wherever you want
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.teal[700],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildServiceCardWithImage({
    required String imageUrl,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: Colors.grey[300],
                      child: Icon(
                        icon,
                        size: 60,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 180,
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
                // Gradient overlay
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
                // Icon badge
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      size: 28,
                      color: iconColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Text content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
