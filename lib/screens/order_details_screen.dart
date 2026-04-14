import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import '../main.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String _selectedMethod = 'Delivery';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _nameController = TextEditingController(text: 'Sonia T.');

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.tertiary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appState = PinkiePieApp.of(context);
    final cartItems = appState.cartItems;
    
    double total = cartItems.fold(0, (sum, item) => sum + item.totalPrice);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: colorScheme.onSurface,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Order Details', style: theme.textTheme.titleLarge),
      ),
      body: cartItems.isEmpty 
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // DELIVERY / PICKUP TOGGLE
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              _buildSegment('Delivery', Icons.directions_bike),
                              _buildSegment('Pickup', Icons.shopping_bag),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        // CONTACT NAME
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Contact Name',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        // DATE & TIME PICKERS
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _pickDate,
                                icon: Icon(Icons.calendar_today, size: 18, color: colorScheme.tertiary),
                                label: Text(
                                  DateFormat('MMM d, yyyy').format(_selectedDate),
                                  style: TextStyle(color: colorScheme.tertiary),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _pickTime,
                                icon: Icon(Icons.access_time, size: 18, color: colorScheme.tertiary),
                                label: Text(
                                  _selectedTime.format(context),
                                  style: TextStyle(color: colorScheme.tertiary),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        
                        Text(
                          'Order Summary',
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        
                        // LIST OF ITEMS
                        ...cartItems.map((item) => _buildSummaryItem(item)).toList(),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                
                // SUBMIT SECTION
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Amount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('\$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colorScheme.tertiary)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            final newOrder = OrderModel(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              items: List.from(appState.cartItems),
                              totalAmount: total,
                              date: _selectedDate,
                              time: _selectedTime.format(context),
                              method: _selectedMethod,
                            );
                            appState.placeOrder(newOrder);
                            
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Order Placed!'),
                                content: const Text('Your delicious bakery treats are being prepared.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Awesome'),
                                  )
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary.withOpacity(0.2),
                            foregroundColor: colorScheme.tertiary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text(
                            'Submit Order',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSegment(String label, IconData icon) {
    final isSelected = _selectedMethod == label;
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedMethod = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.primary.withOpacity(0.3) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isSelected ? colorScheme.onSurface : Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? colorScheme.onSurface : Colors.grey[600],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(CartItem item) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appState = PinkiePieApp.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.primary),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('x${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.dessert.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Price: \$${item.dessert.price.toStringAsFixed(2)}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, size: 20),
                onPressed: () => appState.updateCartQuantity(item.dessert.id, -1),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 20),
                onPressed: () => appState.updateCartQuantity(item.dessert.id, 1),
              ),
              const SizedBox(width: 8),
              Text('\$${item.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
