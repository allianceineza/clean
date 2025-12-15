import 'package:flutter/material.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({Key? key}) : super(key: key);

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  final List<TipCategory> _initialTips = [
    TipCategory(
      title: 'Waste Reduction Tips',
      shortDescription: 'Reduce waste by transforming your unused items into practical solutions with these tips.',
      longDescription: '''
1. **Repurpose Glass Jars**: Clean and save glass jars from pasta sauce, pickles, etc. Use them to store bulk foods, as drinking glasses, or for organizing small items like buttons and screws.

2. **Cloth Instead of Paper**: Use cloth napkins, towels, and rags instead of paper towels. They can be washed and reused hundreds of times.

3. **Buy in Bulk**: Purchase food, cleaning supplies, and personal care items in bulk using your own containers to reduce packaging waste.

4. **Ditch Plastic Wrap**: Use beeswax wraps, silicone lids, or reusable containers to cover food instead of plastic wrap.

5. **Repair Before Replacing**: Fix broken items instead of immediately buying new ones. Many community centers offer repair workshops.
''',
      icon: Icons.reduce_capacity,
    ),
    TipCategory(
      title: 'Recycling Tips',
      shortDescription: 'Make your own produce bags to reduce single-use plastic waste.',
      longDescription: '''
1. **Know Your Local Rules**: Different municipalities accept different materials. Check what can and cannot be recycled in your area.

2. **Clean Containers**: Rinse out food containers before recycling. Food residue can contaminate entire batches of recyclables.

3. **No Plastic Bags in Curbside**: Don't put plastic bags in curbside recycling. Take them to grocery store drop-off locations instead.

4. **DIY Produce Bags**: Sew simple mesh bags from old curtains or tulle for grocery shopping. They're lightweight and washable.

5. **Recycle Electronics Properly**: E-waste contains valuable materials but also toxins. Find certified e-waste recyclers in your community.
''',
      icon: Icons.recycling,
    ),
    TipCategory(
      title: 'Composting Tips',
      shortDescription: 'Turn food scraps into nutrient-rich compost for your plants.',
      longDescription: '''
1. **Balance Greens and Browns**: For successful composting, maintain a ratio of about 2:1 of browns (carbon-rich materials like dry leaves, cardboard) to greens (nitrogen-rich materials like food scraps, grass clippings).

2. **What to Compost**: Fruit and vegetable scraps, coffee grounds, eggshells, yard trimmings, paper towels (unbleached), and houseplants.

3. **What NOT to Compost**: Meat, dairy, oily foods, diseased plants, pet waste, or chemically treated wood.

4. **Small Space Solution**: Use a worm bin (vermicomposting) for apartment composting. Red wiggler worms can process food scraps efficiently.

5. **Use Finished Compost**: Mix compost into garden soil, use as mulch, or make compost tea to fertilize plants.
''',
      icon: Icons.grass,
    ),
    TipCategory(
      title: 'Repurposing and Upcycling Tips',
      shortDescription: 'Creative tips that turn the ordinary into the extraordinary.',
      longDescription: '''
1. **T-shirt to Tote Bag**: Turn old t-shirts into reusable shopping bags by cutting off the sleeves and neckline, then sewing or knotting the bottom.

2. **Wine Cork Board**: Collect wine corks and glue them to a frame to create a unique bulletin board.

3. **Ladder Bookshelf**: Repurpose an old wooden ladder into a leaning bookshelf by adding planks between the rungs.

4. **Mason Jar Organizers**: Attach mason jar lids to the underside of shelves to create hanging storage for small items.

5. **CD/DVD Cases**: Use old CD cases as small picture frames, mini greenhouses for seedlings, or drawer organizers.
''',
      icon: Icons.autorenew,
    ),
    TipCategory(
      title: 'Waste Management Awareness Tips',
      shortDescription: 'Tips about awareness and ideas with regards to waste management process.',
      longDescription: '''
1. **Conduct a Waste Audit**: For one week, track everything you throw away to identify your biggest sources of waste.

2. **Learn About Circular Economy**: Understand how products can be designed to be reused, repaired, or recycled instead of ending up in landfills.

3. **Support Extended Producer Responsibility**: Choose brands that take responsibility for the entire lifecycle of their products, including take-back programs.

4. **Understand Decomposition Times**: 
   - Plastic bottle: 450 years
   - Aluminum can: 200-500 years
   - Glass bottle: 1 million years
   - Paper: 2-6 weeks

5. **Calculate Your Carbon Footprint**: Use online calculators to understand your environmental impact and find ways to reduce it.
''',
      icon: Icons.lightbulb,
    ),
  ];

  final List<TipCategory> _additionalTips = [
    TipCategory(
      title: 'Water Conservation Tips',
      shortDescription: 'Reduce water usage with simple changes in daily habits.',
      longDescription: '''
1. **Fix Leaks Promptly**: A dripping faucet can waste 20 gallons of water per day.
2. **Install Low-Flow Fixtures**: Showerheads and faucet aerators can reduce water use by 30-50%.
3. **Collect Rainwater**: Use rain barrels to collect water for gardening.
4. **Water Plants Wisely**: Water in early morning or late evening to reduce evaporation.
5. **Full Loads Only**: Run dishwashers and washing machines only with full loads.
''',
      icon: Icons.water_drop,
    ),
    TipCategory(
      title: 'Energy Saving Tips',
      shortDescription: 'Reduce energy consumption and lower your carbon footprint.',
      longDescription: '''
1. **LED Lighting**: Switch to LED bulbs which use 75% less energy than incandescent bulbs.
2. **Unplug Electronics**: Use power strips to completely turn off electronics when not in use.
3. **Smart Thermostat**: Program your thermostat to save energy when you're away.
4. **Air Dry Clothes**: Use a clothesline or drying rack instead of a dryer.
5. **Seal Drafts**: Weatherstrip doors and windows to prevent heat loss.
''',
      icon: Icons.energy_savings_leaf,
    ),
  ];

  List<TipCategory> _displayedTips = [];
  bool _showAllTips = false;

  @override
  void initState() {
    super.initState();
    _displayedTips = List.from(_initialTips);
  }

  void _loadMoreTips() {
    setState(() {
      if (!_showAllTips) {
        _displayedTips.addAll(_additionalTips);
        _showAllTips = true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All tips are already loaded!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _showTipDetails(TipCategory tip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Draggable handle
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            tip.icon,
                            color: Colors.teal,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            tip.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          tip.longDescription,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header Section
          _buildHeaderSection(),
          const SizedBox(height: 20),
          
          // Tips Categories
          ..._displayedTips.map((tip) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () => _showTipDetails(tip),
                  child: _buildTipCard(tip),
                ),
                const SizedBox(height: 16),
              ],
            );
          }).toList(),
          
          // Load More Button
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: _loadMoreTips,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                _showAllTips ? 'All Tips Loaded' : 'Load More Tips',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade100, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Helpful tips, courtesy of',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Dr. Francine, Ph.D.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Environmental Engineer & Sustainability Coordinator',
            style: TextStyle(
              fontSize: 14,
              color: Colors.teal.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Adrian.Tennis@gmail.com',
            style: TextStyle(
              fontSize: 14,
              color: Colors.teal.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(TipCategory tip) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    tip.icon,
                    color: Colors.teal,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tip.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.teal,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 1,
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: 12),
            Text(
              tip.shortDescription,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap to view detailed tips →',
              style: TextStyle(
                fontSize: 14,
                color: Colors.teal.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TipCategory {
  final String title;
  final String shortDescription;
  final String longDescription;
  final IconData icon;

  TipCategory({
    required this.title,
    required this.shortDescription,
    required this.longDescription,
    required this.icon,
  });
}