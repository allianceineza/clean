import 'package:flutter/material.dart';
import '../services/database_helper.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List<Map<String, dynamic>> _blogPosts = [];
  bool _isLoading = true;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Environment',
    'Recycling',
    'Sustainability',
    'Rwanda',
  ];

  @override
  void initState() {
    super.initState();
    _loadBlogPosts();
  }

  Future<void> _loadBlogPosts() async {
    try {
      final posts = await DatabaseService.instance.getBlogPosts();
      
      // If no posts in database, add sample posts
      if (posts.isEmpty) {
        setState(() {
          _blogPosts = [
            {
              'title': 'Recycling Tips for Rwanda Households',
              'shortDescription': 'Simple ways to reduce waste and recycle effectively at home',
              'category': 'Recycling',
              'image': 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=400',
              'author': 'CleanRoute Team',
              'date': 'Jan 26, 2026',
              'readTime': '5 min read',
            },
            {
              'title': 'How Trees Fight Climate Change in Rwanda',
              'shortDescription': 'Understanding the impact of reforestation on our environment',
              'category': 'Environment',
              'image': 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=400',
              'author': 'Green Team',
              'date': 'Jan 25, 2026',
              'readTime': '7 min read',
            },
            {
              'title': 'Sustainable Living in Kigali',
              'shortDescription': 'Practical tips for an eco-friendly lifestyle in the city',
              'category': 'Sustainability',
              'image': 'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?w=400',
              'author': 'Eco Warriors',
              'date': 'Jan 24, 2026',
              'readTime': '6 min read',
            },
            {
              'title': 'Community Clean-Up Success Stories',
              'shortDescription': 'How local communities are making a difference together',
              'category': 'Rwanda',
              'image': 'https://images.unsplash.com/photo-1532629345422-7515f3d16bb6?w=400',
              'author': 'Community Team',
              'date': 'Jan 23, 2026',
              'readTime': '4 min read',
            },
            {
              'title': 'Plastic Pollution Solutions',
              'shortDescription': 'Innovative ways to reduce plastic waste in Rwanda',
              'category': 'Environment',
              'image': 'https://images.unsplash.com/photo-1621451537084-482c73073a0f?w=400',
              'author': 'CleanRoute Team',
              'date': 'Jan 22, 2026',
              'readTime': '5 min read',
            },
          ];
          _isLoading = false;
        });
      } else {
        setState(() {
          _blogPosts = posts;
          _isLoading = false;
        });
      }
    } catch (e) {
      // Use sample data on error
      setState(() {
        _blogPosts = [
          {
            'title': 'Recycling Tips for Rwanda Households',
            'shortDescription': 'Simple ways to reduce waste and recycle effectively at home',
            'category': 'Recycling',
            'image': 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=400',
            'author': 'CleanRoute Team',
            'date': 'Jan 26, 2026',
            'readTime': '5 min read',
          },
        ];
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> get _filteredPosts {
    if (_selectedCategory == 'All') return _blogPosts;
    return _blogPosts
        .where((post) => post['category'] == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Blog & News',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Latest updates and stories',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.article,
                          color: Colors.green[700],
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Category Filter
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = _selectedCategory == category;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.green[700]
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey[700],
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Blog Posts
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredPosts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.article_outlined,
                                size: 80,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No blog posts yet',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Check back soon for updates!',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadBlogPosts,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(20),
                            itemCount: _filteredPosts.length,
                            itemBuilder: (context, index) {
                              return _buildBlogCard(_filteredPosts[index]);
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogCard(Map<String, dynamic> post) {
    final imageUrl = post['image'] ??
        'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=400';

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlogDetailPage(blogPost: post),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                imageUrl,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 110,
                    height: 110,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey[500],
                    ),
                  );
                },
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        post['category'] ?? 'Environment',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[700],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Title
                    Text(
                      post['title'] ?? 'Blog Post Title',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Description
                    Text(
                      post['shortDescription'] ??
                          'Learn how small actions make big impact.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        height: 1.4,
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
}

// BLOG DETAIL PAGE 
class BlogDetailPage extends StatelessWidget {
  final Map<String, dynamic> blogPost;

  const BlogDetailPage({Key? key, required this.blogPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = blogPost['image'] ??
        'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=800';

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.green[700],
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.image,
                          size: 80,
                          color: Colors.grey[500],
                        ),
                      );
                    },
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            blogPost['category'] ?? 'Environment',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Title
                        Text(
                          blogPost['title'] ?? 'Blog Post Title',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Author and Date
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.green[100],
                              child: Icon(
                                Icons.person,
                                color: Colors.green[700],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  blogPost['author'] ?? 'CleanRoute Team',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2C3E50),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      blogPost['date'] ?? 'Jan 26, 2026',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      ' • ${blogPost['readTime'] ?? '5 min read'}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        
                        Text(
                          blogPost['content'] ?? blogPost['shortDescription'] ??
                              'This is the blog post content. Add more detailed information about the topic here.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Share Section
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: Colors.green[700],
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Share this article',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildShareButton(
                                    Icons.facebook,
                                    Colors.blue[700]!,
                                  ),
                                  _buildShareButton(
                                    Icons.share,
                                    Colors.green[700]!,
                                  ),
                                  _buildShareButton(
                                    Icons.link,
                                    Colors.grey[700]!,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}