import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/main_navigation.dart';
import 'screens/product_detail_screen.dart';
import 'models/models.dart';
import 'api/mock_pinkie_pie_service.dart';

void main() {
  runApp(const PinkiePieApp());
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class PinkiePieApp extends StatefulWidget {
  const PinkiePieApp({super.key});

  @override
  PinkiePieAppState createState() => PinkiePieAppState();

  static PinkiePieAppState of(BuildContext context) {
    final result = context.findAncestorStateOfType<PinkiePieAppState>();
    if (result != null) return result;
    throw FlutterError('PinkiePieApp state not found in context');
  }
}

class PinkiePieAppState extends State<PinkiePieApp> {
  ThemeMode _themeMode = ThemeMode.light;
  bool _isLoggedIn = false;

  // App State
  final List<CartItem> _cartItems = [];
  final List<OrderModel> _orders = [];
  final List<DessertItem> _favorites = [];

  String _userName = 'Guest';
  String _userEmail = '';

  List<CartItem> get cartItems => _cartItems;
  List<OrderModel> get orders => _orders;
  List<DessertItem> get favorites => _favorites;

  String get userName => _userName;
  String get userEmail => _userEmail;
  ThemeMode get themeMode => _themeMode;
  bool get isLoggedIn => _isLoggedIn;

  void login() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  void logout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  void updateUser(String name, String email) {
    setState(() {
      _userName = name;
      _userEmail = email;
    });
  }

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void addToCart(DessertItem dessert, {int quantity = 1}) {
    setState(() {
      final index = _cartItems.indexWhere((item) => item.dessert.id == dessert.id);
      if (index >= 0) {
        _cartItems[index].quantity += quantity;
      } else {
        _cartItems.add(CartItem(dessert: dessert, quantity: quantity));
      }
    });
  }

  void updateCartQuantity(String id, int delta) {
    setState(() {
      final index = _cartItems.indexWhere((item) => item.dessert.id == id);
      if (index >= 0) {
        _cartItems[index].quantity += delta;
        if (_cartItems[index].quantity <= 0) {
          _cartItems.removeAt(index);
        }
      }
    });
  }

  void clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  void placeOrder(OrderModel order) {
    setState(() {
      _orders.insert(0, order);
      _cartItems.clear();
    });
  }

  void toggleFavorite(DessertItem dessert) {
    setState(() {
      final index = _favorites.indexWhere((item) => item.id == dessert.id);
      if (index >= 0) {
        _favorites.removeAt(index);
        dessert.isFavorite = false;
      } else {
        _favorites.add(dessert);
        dessert.isFavorite = true;
      }
    });
  }

  late final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/0',
    redirect: (context, state) {
      if (!_isLoggedIn && state.matchedLocation != '/login' && state.matchedLocation != '/register' && state.matchedLocation != '/onboarding') {
        return '/login';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/:tab',
        builder: (context, state) {
          final tabStr = state.pathParameters['tab'] ?? '0';
          final tabIndex = int.tryParse(tabStr) ?? 0;
          return MainNavigation(tabIndex: tabIndex);
        },
        routes: [
          GoRoute(
            path: 'restaurant/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              // Fallback to a mock dessert if ID doesn't match
              return FutureBuilder<List<DessertItem>>(
                future: MockPinkiePieService().getAllDesserts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final dessert = snapshot.data!.firstWhere(
                      (d) => d.id == id,
                      orElse: () => snapshot.data!.first,
                    );
                    return ProductDetailScreen(
                      dessert: dessert,
                      onToggleFavorite: (item) => toggleFavorite(item),
                      onAddToCart: (item) => addToCart(item),
                    );
                  }
                  return const Scaffold(body: Center(child: CircularProgressIndicator()));
                },
              );
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Pinkie Pie',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFFF8FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE8AFC1),
          primary: const Color(0xFFE8AFC1),
          onPrimary: Colors.white,
          secondary: const Color(0xFFD98CA3),
          onSecondary: Colors.white,
          tertiary: const Color(0xFFA64D79),
          surface: Colors.white,
          onSurface: const Color(0xFF333333),
          outline: const Color(0xFFF3D6E0),
        ),
        fontFamily: 'Serif',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFAD1457),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: _themeMode,
    );
  }
}
