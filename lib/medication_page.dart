import 'package:flutter/material.dart';
import 'cart.dart';
import 'cart_page.dart';
import 'orders_page.dart';
import 'services/app_error.dart';
import 'services/medication_service.dart';
import 'widgets/load_state.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  // Medications come from the database (via the backend),
  // grouped by category in the order they arrive.
  Map<String, List<Medication>> medications = {};
  String selectedCategory = '';
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadMedications();
  }

  Future<void> loadMedications() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await MedicationService().medications();
      final grouped = <String, List<Medication>>{};
      for (final medication in result) {
        grouped.putIfAbsent(medication.category, () => []).add(medication);
      }

      if (!mounted) return;
      setState(() {
        medications = grouped;
        if (!grouped.containsKey(selectedCategory)) {
          selectedCategory = grouped.isEmpty ? '' : grouped.keys.first;
        }
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = AppError.message(e);
        isLoading = false;
      });
    }
  }

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );
  }

  void openOrders() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrdersPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableMedication = medications[selectedCategory] ?? [];

    // Rebuild whenever the cart changes so the buttons and totals stay in sync.
    return ValueListenableBuilder<Map<String, CartLine>>(
      valueListenable: Cart.lines,
      builder: (context, cartLines, _) => Scaffold(

        // App Bar
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Order Medication',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'My orders',
              onPressed: openOrders,
              icon: const Icon(Icons.receipt_long_outlined),
            ),
            IconButton(
              tooltip: 'Cart',
              onPressed: openCart,
              icon: Badge(
                isLabelVisible: Cart.itemCount > 0,
                label: Text('${Cart.itemCount}'),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ],
        ),

        // "View cart" bar at the bottom once something has been added
        bottomNavigationBar: cartLines.isEmpty
            ? null
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: openCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2F80ED),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.shopping_cart_outlined),
                          const SizedBox(width: 10),
                          Text(
                            'View cart (${Cart.itemCount})',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            formatRand(Cart.subtotal),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

        body: isLoading || errorMessage != null
            ? LoadState(
                isLoading: isLoading,
                errorMessage: errorMessage,
                onRetry: loadMedications,
              )
            : Column(
                children: [
                  // Category Selection
                  SizedBox(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      children: medications.keys.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: category == selectedCategory,
                            onSelected: (selected) {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Medication List
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      itemCount: availableMedication.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) return _safetyNote();
                        return _medicationCard(availableMedication[index - 1]);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _safetyNote() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF2A100).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Color(0xFFF2A100)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'A pharmacist will check your order before it is ready. '
              'Ask them if you are unsure a medication is right for you.',
            ),
          ),
        ],
      ),
    );
  }

  Widget _medicationCard(Medication medication) {
    final quantity = Cart.quantityOf(medication.id);
    final price = medication.price;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Medication Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.medication_outlined,
              color: Color(0xFF2F80ED),
            ),
          ),

          const SizedBox(width: 15),

          // Medication Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medication.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  medication.type,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Text(
                  formatRand(price),
                  style: const TextStyle(
                    color: Color(0xFF2F80ED),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Add button, or - 2 + once it's in the cart
          if (quantity == 0)
            ElevatedButton(
              onPressed: () => Cart.setQuantity(medication, 1),
              child: const Text('Add'),
            )
          else
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    tooltip: quantity == 1 ? 'Remove' : 'Less',
                    onPressed: () =>
                        Cart.setQuantity(medication, quantity - 1),
                    icon: Icon(
                      quantity == 1 ? Icons.delete_outline : Icons.remove,
                      size: 20,
                    ),
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    tooltip: 'More',
                    onPressed: quantity >= Cart.maxQuantity
                        ? null
                        : () => Cart.setQuantity(medication, quantity + 1),
                    icon: const Icon(Icons.add, size: 20),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
