import '../models/models.dart';

class ExploreData {
  final List<DessertItem> featuredDesserts;
  final List<SweetCategory> categories;
  final List<ReviewPost> activityPosts;

  ExploreData({
    required this.featuredDesserts,
    required this.categories,
    required this.activityPosts,
  });
}

class MockPinkiePieService {
  static final List<DessertItem> _allDesserts = [
    DessertItem(
      id: '1',
      name: 'Strawberry Cupcake',
      description: 'Moist pink velvet cake topped with creamy strawberry frosting and a fresh berry.',
      imageUrl: 'assets/desserts/cupcake_1.png',
      price: 4.50,
      rating: 4.9,
      category: 'Cupcakes',
      tags: ['Handmade', 'Best Seller'],
    ),
    DessertItem(
      id: '2',
      name: 'Rose Macaron Box',
      description: 'A delicate collection of rose-infused macarons made with French almond flour.',
      imageUrl: 'assets/desserts/macarons_1.png',
      price: 18.00,
      rating: 4.8,
      category: 'Macarons',
      tags: ['Elegant', 'Gift'],
    ),
    DessertItem(
      id: '3',
      name: 'Strawberry Dream Cake',
      description: 'Layers of fluffy sponge cake filled with fresh strawberries and light vanilla cream.',
      imageUrl: 'assets/desserts/cake1.png',
      price: 35.00,
      rating: 5.0,
      category: 'Cakes',
      tags: ['Fresh', 'Celebration'],
    ),
    DessertItem(
      id: '4',
      name: 'Vanilla Swirl Cake',
      description: 'Elegant vanilla sponge with signature pink frosting swirls and sprinkles.',
      imageUrl: 'assets/desserts/cake2.png',
      price: 28.00,
      rating: 4.7,
      category: 'Cakes',
      tags: ['Classic', 'Popular'],
    ),
    DessertItem(
      id: '5',
      name: 'Caramel Cookie',
      description: 'Handcrafted cookies with white chocolate chunks and sea salt caramel drizzle.',
      imageUrl: 'assets/desserts/cookie_1.png',
      price: 12.00,
      rating: 4.9,
      category: 'Cookies',
      tags: ['Handmade', 'Gift'],
    ),
    DessertItem(
      id: '6',
      name: 'Glazed Berry Donut',
      description: 'Freshly baked donut dipped in our secret berry glaze and topped with dried fruit.',
      imageUrl: 'assets/desserts/donut_1.png',
      price: 3.50,
      rating: 4.6,
      category: 'Donuts',
      tags: ['Fresh', 'Sweet'],
    ),
    DessertItem(
      id: '7',
      name: 'Cream Puff Tower',
      description: 'A beautiful assortment of light-as-air pastry puffs filled with vanilla bean custard.',
      imageUrl: 'assets/desserts/detail_1.png',
      price: 22.00,
      rating: 4.9,
      category: 'Pastries',
      tags: ['Variety', 'Party'],
    ),
    DessertItem(
      id: '8',
      name: 'Berry Bliss Tart',
      description: 'Crisp pastry shell filled with vanilla bean custard and seasonal fresh berries.',
      imageUrl: 'assets/desserts/detail_2.png',
      price: 6.50,
      rating: 4.8,
      category: 'Pastries',
      tags: ['Fresh', 'Fruity'],
    ),
  ];

  Future<ExploreData> getExploreData() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final categories = [
      SweetCategory(id: 'c1', title: 'Cakes', imageUrl: 'assets/categories/cakes.png', itemCount: 12),
      SweetCategory(id: 'c2', title: 'Cookies', imageUrl: 'assets/categories/cookies.png', itemCount: 10),
      SweetCategory(id: 'c3', title: 'Cupcakes', imageUrl: 'assets/categories/cupcakes.png', itemCount: 8),
      SweetCategory(id: 'c4', title: 'Donuts', imageUrl: 'assets/categories/donuts.png', itemCount: 6),
      SweetCategory(id: 'c5', title: 'Macarons', imageUrl: 'assets/categories/macarons.png', itemCount: 15),
      SweetCategory(id: 'c6', title: 'Pastries', imageUrl: 'assets/categories/pastries.png', itemCount: 9),
    ];

    final activityPosts = [
      ReviewPost(
        id: 'p1',
        userName: 'Sophia L.',
        userAvatar: 'assets/avatars/user_1.png',
        message: 'The Strawberry Dream Cake was the centerpiece of our garden party. Truly exquisite taste.',
        timeAgo: '2h ago',
      ),
      ReviewPost(
        id: 'p2',
        userName: 'Emma R.',
        userAvatar: 'assets/avatars/user_2.png',
        message: 'Elegant packaging and even better macarons. The rose flavor is perfectly balanced.',
        timeAgo: '5h ago',
      ),
      ReviewPost(
        id: 'p3',
        userName: 'Olivia W.',
        userAvatar: 'assets/avatars/user_3.png',
        message: 'These cupcakes are dangerously delicious! The Strawberry Cupcake is my absolute favorite.',
        timeAgo: '1d ago',
      ),
    ];

    return ExploreData(
      featuredDesserts: _allDesserts,
      categories: categories,
      activityPosts: activityPosts,
    );
  }

  Future<List<DessertItem>> getAllDesserts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _allDesserts;
  }
}
