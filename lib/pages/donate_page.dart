import 'package:flutter/material.dart';
import '../screens/billing_screen.dart'; // Add this import

class DonatePage extends StatefulWidget {
  const DonatePage({Key? key}) : super(key: key);

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  String selectedTab = 'Our Campaigns';

  final List<Map<String, dynamic>> campaigns = [
    {
      'title': 'Plant Trees in Rwanda',
      'description': 'Help us restore Rwanda\'s forests. Each tree fights climate change and supports local communities',
      'image': 'https://cdn.shopify.com/s/files/1/0326/7189/files/Rwanda_Intro.jpg?v=1726840780',
      'icon': Icons.park,
      'color': Colors.green,
    },
    {
      'title': 'Reforest Gishwati Forest',
      'description': 'Support the restoration of Gishwati-Mukura National Park, home to endangered species',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyhAanKI58Kmom6zyyDEY6gEINxb-IAH7YcQ&s',
      'icon': Icons.forest,
      'color': Color(0xFF2E7D32),
    },
    {
      'title': 'School Tree Planting Program',
      'description': 'Engage Rwandan students in environmental conservation through tree planting initiatives',
      'image': 'https://www.juc-rwb.org/wp-content/uploads/2022/12/FiykjcrXkAAjnQS-1024x683.jpg',
      'icon': Icons.school,
      'color': Color(0xFF388E3C),
    },
    {
      'title': ' Green Kigali',
      'description': 'Transform Kigali into Africa\'s greenest city with urban tree planting projects',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVZperz2jY5WYhhwkNJr21eGEaCBybjU6ThA&s',
      'icon': Icons.location_city,
      'color': Color(0xFF43A047),
    },
    {
      'title': 'Coffee Farm  Trees',
      'description': 'Plant shade trees for coffee farmers to improve yields and protect the environment',
      'image': 'https://www.shutterstock.com/image-photo/cropped-photo-african-american-farm-260nw-2183118243.jpg',
      'icon': Icons.coffee,
      'color': Color(0xFF6D4C41),
    },
    {
      'title': 'Volcanoes National Park',
      'description': 'Support bamboo and tree restoration in the home of mountain gorillas',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzsTozM1oDjCgqMeV8V8Av7Uae9GaBq7V3Bw&s',
      'icon': Icons.terrain,
      'color': Color(0xFF558B2F),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Donate',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
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
                children: [
                  // Header Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://www.safarisrwandasafari.com/wp-content/uploads/2023/06/An_aerial_of_Kigali_Convention_Center_on_June_19_2019._Photo_by_Emmanuel_Kwizera-750x450.jpg',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 70,
                          height: 70,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.eco,
                            size: 40,
                            color: Colors.green[700],
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              strokeWidth: 2,
                              color: Colors.green[700],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Text
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.4,
                          color: Colors.black87,
                        ),
                        children: [
                          const TextSpan(text: 'Let\'s make '),
                          TextSpan(
                            text: 'Rwanda',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ' '),
                          const TextSpan(
                            text: 'greener',
                            style: TextStyle(
                              color: Color(0xFFFFD700),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ', one '),
                          TextSpan(
                            text: 'tree',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ' at a time.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tab Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildTabButton('Our Campaigns'),
                  const SizedBox(width: 12),
                  _buildTabButton('Ongoing'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Campaigns List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: campaigns.length,
              itemBuilder: (context, index) {
                final campaign = campaigns[index];
                return _buildCampaignCard(campaign);
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String title) {
    final isSelected = selectedTab == title;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Colors.green[700]! : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.green[700] : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    return GestureDetector(
      onTap: () => _showDonateDialog(campaign),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campaign Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.network(
                campaign['image'],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to icon if image fails to load
                  return Container(
                    width: 100,
                    height: 100,
                    color: campaign['color'].withOpacity(0.1),
                    child: Icon(
                      campaign['icon'],
                      size: 50,
                      color: campaign['color'],
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 100,
                    height: 100,
                    color: campaign['color'].withOpacity(0.1),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        strokeWidth: 2,
                        color: campaign['color'],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Campaign Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      campaign['description'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            
            // Arrow Icon
            Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDonateDialog(Map<String, dynamic> campaign) {
    final amountController = TextEditingController();
    final messageController = TextEditingController();
    String? selectedAmount;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: EdgeInsets.zero,
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: campaign['color'].withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            campaign['icon'],
                            color: campaign['color'],
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                campaign['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Support this campaign',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Amount',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        // Quick Amount Buttons
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: ['1000', '2500', '5000', '10000'].map((amount) {
                            final isSelected = selectedAmount == amount;
                            return GestureDetector(
                              onTap: () {
                                setDialogState(() {
                                  selectedAmount = amount;
                                  amountController.text = amount;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? campaign['color']
                                      : Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected
                                        ? campaign['color']
                                        : Colors.grey[300]!,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'RWF $amount',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected 
                                            ? Colors.white 
                                            : Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      '${(int.parse(amount) / 1000).toStringAsFixed(0)} trees',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: isSelected 
                                            ? Colors.white.withOpacity(0.9)
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 16),
                        
                        // Custom Amount
                        TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Or enter custom amount',
                            prefixText: 'RWF ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          onChanged: (value) {
                            setDialogState(() {
                              selectedAmount = null;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        // Optional Message
                        TextField(
                          controller: messageController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Message (Optional)',
                            hintText: 'Add a message of support...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  amountController.dispose();
                  messageController.dispose();
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (amountController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter an amount'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                    return;
                  }

                  // Store the donation details
                  final donationAmount = amountController.text;
                  final campaignTitle = campaign['title'];
                  final donationMessage = messageController.text;

                  // Close dialog
                  Navigator.pop(context);
                  
                  // Navigate to billing screen for payment
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BillingScreen(
                        donationAmount: donationAmount,
                        campaignName: campaignTitle,
                        message: donationMessage,
                      ),
                    ),
                  ).then((_) {
                    // Clean up controllers after returning from billing
                    amountController.dispose();
                    messageController.dispose();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: campaign['color'],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Donate Now',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showSuccessDialog(Map campaign, String amount, String message) {
    final trees = (int.parse(amount) / 1000).toStringAsFixed(0);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        icon: Icon(
          Icons.eco,
          color: Colors.green,
          size: 80,
        ),
        title: const Text(
          'Murakoze! Thank You!',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Your donation of RWF $amount to "${campaign['title']}" will plant approximately $trees trees!\n\nTogether, we are making Rwanda greener and fighting climate change. 🌳🇷🇼',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Done',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}