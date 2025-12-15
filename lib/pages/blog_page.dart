import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  // Initial blog posts
  final List<BlogPost> _initialBlogPosts = [
    BlogPost(
      title: 'Repurpose old jars into candle holders',
      shortDescription: 'Turn old glass jars into beautiful candle holders with these simple steps.',
      category: 'Home Decor',
      date: '11/17/2024',
      author: 'Jack Black',
      materials: [
        'Old glass jars',
        'Tealight candles or small pillar candles',
        'Acrylic paint or spray paint',
        'Paintbrushes or sponges',
        'Decorative items: twine, lace, beads, ribbons, stickers, or dried flowers',
        'Hot glue gun or craft glue',
        'Sandpaper',
        'Scissors',
        'Rubbing alcohol',
      ],
      steps: [
        'Clean the Jar: Wash with soap, remove labels, and clean with rubbing alcohol.',
        'Decorate (Optional): Paint the jar or wrap it with twine or ribbon. Add beads, lace, or flowers with glue.',
        'Add Support (Optional): Fill the base with sand, pebbles, or beans to stabilize the candle.',
        'Insert Candle: Place a tealight or small pillar candle inside the jar.',
        'Light & Enjoy: Ensure the jar is on a heat-resistant surface, and enjoy the glow!',
        'Tip: Use LED candles for a safer option.',
      ],
      joke: 'Why did the old jar apply for a job? Because it wanted to be a part of a DIY project!',
      imageAsset: 'assets/jar_candle.jpg', // You'll need to add this image to your assets
    ),
    BlogPost(
      title: 'Create a gallery wall with old frames',
      shortDescription: 'Transform your old frames into a stunning gallery wall with these creative ideas.',
      category: 'Home Decor',
      date: '11/10/2024',
      author: 'Sarah Johnson',
      materials: [
        'Old picture frames of various sizes',
        'Sandpaper',
        'Spray paint or acrylic paint',
        'Wall hooks and nails',
        'Level',
        'Measuring tape',
      ],
      steps: [
        'Prepare Frames: Sand down any rough edges and paint frames in your chosen colors.',
        'Arrange Layout: Lay frames on the floor to experiment with different arrangements.',
        'Measure Wall Space: Determine the area where you want your gallery wall.',
        'Create Templates: Trace frames on paper and tape templates to the wall.',
        'Hang Frames: Use templates as guides to hang frames securely.',
        'Add Art: Insert photos, prints, or fabric into frames.',
      ],
      joke: 'Why did the picture frame go to therapy? It had too many issues to hang!',
      imageAsset: 'assets/gallery_wall.jpg',
    ),
    BlogPost(
      title: 'Upcycle old t-shirts into a colorful rug',
      shortDescription: 'Transform your old t-shirts into an easy rug with this creative DIY project.',
      category: 'Textile Upcycling',
      date: '11/03/2024',
      author: 'Emma Wilson',
      materials: [
        'Old cotton t-shirts (5-10 depending on rug size)',
        'Scissors',
        'Crochet hook (size 10mm)',
        'Non-slip rug mat (optional)',
      ],
      steps: [
        'Prepare T-shirts: Cut off seams and cut t-shirts into 1-inch wide strips.',
        'Join Strips: Tie strips together to create one long continuous "yarn".',
        'Start Crocheting: Chain stitch to desired rug width.',
        'Single Crochet: Work single crochet stitches back and forth.',
        'Finish: When rug reaches desired length, cut and weave in ends.',
        'Add Backing: Attach non-slip mat to bottom if desired.',
      ],
      joke: 'Why did the t-shirt go to school? It wanted to be a little more "knit"elligent!',
      imageAsset: 'assets/tshirt_rug.jpg',
    ),
    BlogPost(
      title: 'Build a bird feeder out of recycled tin',
      shortDescription: 'Create a sustainable bird feeder from recycled tin cans.',
      category: 'Garden & Outdoor',
      date: '10/27/2024',
      author: 'Mike Chen',
      materials: [
        'Clean tin can with label removed',
        'Wooden spoon or dowel',
        'Strong adhesive or epoxy',
        'Drill',
        'Sandpaper',
        'Paint (optional)',
        'Wire or string for hanging',
      ],
      steps: [
        'Prepare Can: Remove label, clean thoroughly, and sand any sharp edges.',
        'Create Perch: Drill a hole near the bottom and insert wooden spoon as a perch.',
        'Add Drainage: Drill small holes in the bottom for drainage.',
        'Make Hanging Holes: Drill two holes near the top opposite each other.',
        'Decorate (Optional): Paint the can with non-toxic paint.',
        'Assemble: Attach wire or string through hanging holes.',
        'Fill: Add birdseed and hang in a sheltered location.',
      ],
      joke: 'Why did the bird feeder break up with the snow? It found someone more supportive!',
      imageAsset: 'assets/bird_feeder.jpg',
    ),
    BlogPost(
      title: 'Make planters from empty cans',
      shortDescription: 'Transform empty cans into beautiful planters for your herbs and succulents.',
      category: 'Garden & Outdoor',
      date: '10/20/2024',
      author: 'Lisa Rodriguez',
      materials: [
        'Empty food cans (various sizes)',
        'Hammer and nail',
        'Spray paint',
        'Potting soil',
        'Small plants or seeds',
        'Decorative rocks or moss (optional)',
      ],
      steps: [
        'Clean Cans: Remove labels and wash thoroughly with soap.',
        'Drainage Holes: Use hammer and nail to make 3-4 holes in the bottom.',
        'Paint Cans: Spray paint cans in desired colors and let dry completely.',
        'Add Soil: Fill cans ¾ full with potting soil.',
        'Plant: Add small plants or seeds according to their needs.',
        'Decorate: Top with decorative rocks or moss.',
        'Water Lightly: Be careful not to overwater.',
      ],
      joke: 'Why did the empty can go to school? Because it wanted to be a little more (can-do)!',
      imageAsset: 'assets/can_planter.jpg',
    ),
  ];

  // Additional blog posts for "Load More"
  final List<BlogPost> _additionalBlogPosts = [
    BlogPost(
      title: 'Turn wine bottles into garden edging',
      shortDescription: 'Create beautiful garden borders using recycled wine bottles.',
      category: 'Garden & Outdoor',
      date: '10/13/2024',
      author: 'Tom Baker',
      materials: [
        'Empty wine bottles (green or brown work best)',
        'Garden spade',
        'Sand',
        'Rubber mallet',
      ],
      steps: [
        'Collect Bottles: Save wine bottles and remove labels.',
        'Dig Trench: Dig a shallow trench along your garden border.',
        'Add Sand: Fill bottom of trench with 1 inch of sand for stability.',
        'Place Bottles: Insert bottles neck-down into the trench.',
        'Secure: Pack soil around bottles and tap gently with rubber mallet.',
        'Water: Water the soil to help settle everything in place.',
      ],
      joke: 'Why did the wine bottle join the garden? It wanted to be a little more grounded!',
      imageAsset: 'assets/wine_bottle_edging.jpg',
    ),
    BlogPost(
      title: 'Create storage from cardboard boxes',
      shortDescription: 'Turn shipping boxes into stylish storage solutions.',
      category: 'Home Organization',
      date: '10/06/2024',
      author: 'Rachel Green',
      materials: [
        'Cardboard boxes of various sizes',
        'Wrapping paper or fabric',
        'Mod Podge or white glue',
        'Scissors or box cutter',
        'Ruler',
        'Decorative knobs (optional)',
      ],
      steps: [
        'Reinforce Boxes: Tape corners and edges for extra strength.',
        'Cover: Cut wrapping paper or fabric to fit and glue onto boxes.',
        'Create Dividers: Cut cardboard pieces to create compartments.',
        'Add Handles: Cut openings for handles or attach decorative knobs.',
        'Stack: Arrange boxes to create a custom storage unit.',
        'Label: Add labels to keep organized.',
      ],
      joke: 'Why was the cardboard box so good at sports? It had great boxing skills!',
      imageAsset: 'assets/cardboard_storage.jpg',
    ),
  ];

  List<BlogPost> _displayedPosts = [];
  bool _showAllPosts = false;

  @override
  void initState() {
    super.initState();
    _displayedPosts = List.from(_initialBlogPosts);
  }

  void _loadMorePosts() {
    setState(() {
      if (!_showAllPosts) {
        _displayedPosts.addAll(_additionalBlogPosts);
        _showAllPosts = true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All blog posts are already loaded!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _showBlogDetails(BlogPost post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlogDetailPage(blogPost: post),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.teal.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '5 DIY to do at Home',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Turn old items into something useful with these fun DIY ideas.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.teal.shade700,
                  ),
                ),
              ],
            ),
          ),
          
          // Blog Posts List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _displayedPosts.length + 1, // +1 for the Load More button
              itemBuilder: (context, index) {
                if (index < _displayedPosts.length) {
                  final post = _displayedPosts[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => _showBlogDetails(post),
                        child: _buildBlogCard(post),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                } else {
                  // Load More Button
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: _loadMorePosts,
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
                          _showAllPosts ? 'All Posts Loaded' : 'Load More',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogCard(BlogPost post) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder (you can replace with actual images)
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: const DecorationImage(
                image: AssetImage('assets/diy_placeholder.jpg'), // Add a placeholder image
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.construction,
                size: 60,
                color: Colors.teal.shade800.withOpacity(0.7),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        post.category,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.teal.shade700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      post.date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  post.shortDescription,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.teal.shade100,
                      child: Icon(
                        Icons.person,
                        size: 14,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'By ${post.author}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.teal,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Read More',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.teal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BlogDetailPage extends StatelessWidget {
  final BlogPost blogPost;

  const BlogDetailPage({Key? key, required this.blogPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Post'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category and Date
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    blogPost.category,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.teal.shade700,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  blogPost.date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Title
            Text(
              blogPost.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            
            // Author
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.teal.shade100,
                  child: Icon(
                    Icons.person,
                    size: 18,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  blogPost.author,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            
            // Short Description
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.shade100),
              ),
              child: Text(
                blogPost.shortDescription,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal.shade800,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // Joke Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emoji_emotions,
                        color: Colors.amber.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Recycling Humor',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    blogPost.joke,
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.amber.shade900,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            // Materials Required
            const Text(
              'Materials Required:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 15),
            ...blogPost.materials.asMap().entries.map((entry) {
              final index = entry.key;
              final material = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        material,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 40),
            
            // Steps
            const Text(
              'Steps:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 15),
            ...blogPost.steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          step,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 30),
            
            // Share Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Share functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Blog post shared!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.share),
                label: const Text('Share This DIY Idea'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class BlogPost {
  final String title;
  final String shortDescription;
  final String category;
  final String date;
  final String author;
  final List<String> materials;
  final List<String> steps;
  final String joke;
  final String imageAsset;

  BlogPost({
    required this.title,
    required this.shortDescription,
    required this.category,
    required this.date,
    required this.author,
    required this.materials,
    required this.steps,
    required this.joke,
    required this.imageAsset,
  });
}