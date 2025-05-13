import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  final List<Map<String, String>> products = [
    {
      "name": "Fresh Apples",
      "category": "Fruit",
      "price": "Rs. 120/kg",
      "image": "assets/market/apple.webp",
    },
    {
      "name": "Organic Tomatoes",
      "category": "Vegetable",
      "price": "Rs. 90/kg",
      "image": "assets/market/tomato.jpg",
    },
    {
      "name": "Milk (1L)",
      "category": "Dairy",
      "price": "Rs. 80",
      "image": "assets/market/milk.webp",
    },
    {
      "name": "Spinach",
      "category": "Vegetable",
      "price": "Rs. 40/bunch",
      "image": "assets/market/spinach.webp",
    },
    {
      "name": "Bananas",
      "category": "Fruit",
      "price": "Rs. 70/dozen",
      "image": "assets/market/bananas.jpg",
    },
    {
      "name": "Paneer (250g)",
      "category": "Dairy",
      "price": "Rs. 150",
      "image": "assets/market/paneer.jpg",
    },
    {
      "name": "Brown Eggs (12)",
      "category": "Egg",
      "price": "Rs. 130",
      "image": "assets/market/egg.jpg",
    },
    {
      "name": "Chicken Meat (1kg)",
      "category": "Meat",
      "price": "Rs. 350",
      "image": "assets/market/chicken.jpg",
    },
    {
      "name": "Pure Honey (500ml)",
      "category": "Honey",
      "price": "Rs. 300",
      "image": "assets/market/honey.avif",
    },
  ];

  final List<Map<String, String>> cart = [];
  String searchQuery = '';
  String selectedCategory = 'All';

  List<Map<String, String>> get filteredProducts {
    return products.where((product) {
      final matchesSearch = product["name"]!.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      final matchesCategory =
          selectedCategory == 'All' ||
          product["category"]!.toLowerCase() == selectedCategory.toLowerCase();
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void addToCart(Map<String, String> product) {
    setState(() {
      cart.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product["name"]} added to cart!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void viewCart() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cart',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return ListTile(
                        leading: Image.asset(
                          item["image"]!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item["name"] ?? ''),
                        subtitle: Text(item["price"] ?? ''),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All',
      'Vegetable',
      'Fruit',
      'Egg',
      'Meat',
      'Honey',
      'Dairy',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organic Market'),
        backgroundColor: Colors.green, // ✅ FIXED HERE
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: viewCart,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          // Category Filter Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final category in categories)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        selectedColor: Colors.green.shade300,
                        backgroundColor: Colors.grey.shade200,
                        labelStyle: TextStyle(
                          color:
                              selectedCategory == category
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Product List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final item = filteredProducts[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.asset(
                      item["image"]!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        );
                      },
                    ),
                    title: Text(item["name"] ?? ''),
                    subtitle: Text('${item["category"]} • ${item["price"]}'),
                    trailing: ElevatedButton(
                      onPressed: () => addToCart(item),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Add'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
