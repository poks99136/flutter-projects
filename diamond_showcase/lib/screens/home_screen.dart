import 'package:flutter/material.dart';
import '../models/diamond.dart';
import '../widgets/diamond_card.dart';
import 'add_diamond_screen.dart';
import 'diamond_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample diamond data - Replace with your actual diamonds
  List<Diamond> diamonds = [
    Diamond(
      id: '1',
      name: 'Brilliant Round Diamond',
      imageUrl: 'assets/images/diamond1.jpg',
      description: 'Stunning lab-grown round brilliant diamond with exceptional sparkle. Perfect for engagement rings.',
      carat: 1.5,
      cut: 'Excellent',
      clarity: 'VVS1',
      color: 'D',
      price: 2500.00,
      category: 'engagement',
    ),
    Diamond(
      id: '2',
      name: 'Princess Cut Diamond',
      imageUrl: 'assets/images/diamond2.jpg',
      description: 'Beautiful princess cut lab-grown diamond with modern elegance.',
      carat: 1.2,
      cut: 'Very Good',
      clarity: 'VS1',
      color: 'E',
      price: 1800.00,
      category: 'engagement',
    ),
    Diamond(
      id: '3',
      name: 'Emerald Cut Diamond',
      imageUrl: 'assets/images/diamond3.jpg',
      description: 'Classic emerald cut with stunning clarity and vintage appeal.',
      carat: 2.0,
      cut: 'Excellent',
      clarity: 'VVS2',
      color: 'F',
      price: 3200.00,
      category: 'necklace',
    ),
  ];

  String selectedCategory = 'all';
  String searchQuery = '';

  List<Diamond> get filteredDiamonds {
    return diamonds.where((diamond) {
      final matchesCategory = selectedCategory == 'all' || diamond.category == selectedCategory;
      final matchesSearch = diamond.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          diamond.description.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diamond Showcase'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Navigate to favorites
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search diamonds...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          // Category Filter
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryChip('all', 'All'),
                _buildCategoryChip('engagement', 'Engagement'),
                _buildCategoryChip('earrings', 'Earrings'),
                _buildCategoryChip('necklace', 'Necklace'),
                _buildCategoryChip('bracelet', 'Bracelet'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Diamond Grid
          Expanded(
            child: filteredDiamonds.isEmpty
                ? Center(
                    child: Text(
                      'No diamonds found',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredDiamonds.length,
                    itemBuilder: (context, index) {
                      return DiamondCard(
                        diamond: filteredDiamonds[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiamondDetailsScreen(
                                diamond: filteredDiamonds[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddDiamondScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoryChip(String category, String label) {
    final isSelected = selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedCategory = category;
          });
        },
        backgroundColor: Colors.white,
        selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
        checkmarkColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
