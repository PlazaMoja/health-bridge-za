import 'package:flutter/material.dart';

import 'cart.dart';
import 'dataconnect_generated/generated.dart';
import 'orders_page.dart';
import 'services/account_service.dart';
import 'services/app_error.dart';
import 'services/medication_service.dart';
import 'services/sql_service.dart';

/// The cart and checkout: change quantities, choose collection or delivery,
/// and place the order.
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static const deliveryFee = MedicationService.deliveryFee;

  final addressController = TextEditingController();
  final notesController = TextEditingController();

  String fulfilment = 'collect'; // or 'delivery'
  List<ListClinicsClinics> clinics = [];
  String? selectedClinicId;
  bool isLoadingClinics = true;
  String? clinicsError;
  bool isPlacing = false;

  @override
  void initState() {
    super.initState();
    loadClinics();
    prefillAddress();
  }

  @override
  void dispose() {
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> loadClinics() async {
    setState(() {
      isLoadingClinics = true;
      clinicsError = null;
    });
    try {
      final result = await SqlService().clinics();
      if (!mounted) return;
      setState(() {
        clinics = result;
        selectedClinicId ??= result.isEmpty ? null : result.first.id;
        isLoadingClinics = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        clinicsError = AppError.message(e);
        isLoadingClinics = false;
      });
    }
  }

  // Fills in the delivery address from Profile > Personal Information, if saved.
  Future<void> prefillAddress() async {
    try {
      final details = await AccountService().loadPersonalDetails();
      if (!mounted) return;
      if (addressController.text.isEmpty) {
        addressController.text = details.address;
      }
    } catch (_) {
      // Not important - the user can type the address.
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> placeOrder() async {
    if (Cart.lines.value.isEmpty) {
      showMessage('Your cart is empty.');
      return;
    }
    if (fulfilment == 'collect' && selectedClinicId == null) {
      showMessage('Please choose a clinic to collect from.');
      return;
    }
    if (fulfilment == 'delivery' && addressController.text.trim().length < 5) {
      showMessage('Please enter your full delivery address.');
      return;
    }

    setState(() => isPlacing = true);
    try {
      await MedicationService().placeOrder(
        quantities: {
          for (final line in Cart.lines.value.values)
            line.medication: line.quantity,
        },
        fulfilment: fulfilment,
        clinicId: fulfilment == 'collect' ? selectedClinicId : null,
        deliveryAddress:
            fulfilment == 'delivery' ? addressController.text.trim() : null,
        notes: notesController.text.trim(),
      );
      Cart.clear();
      if (!mounted) return;
      showMessage('Order placed! A pharmacist will check it shortly.');
      // Swap the cart for the orders list so "back" returns to medications.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OrdersPage()),
      );
    } catch (e) {
      if (!mounted) return;
      showMessage(AppError.message(e));
    } finally {
      if (mounted) setState(() => isPlacing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, CartLine>>(
      valueListenable: Cart.lines,
      builder: (context, lines, _) {
        final fee = fulfilment == 'delivery' ? deliveryFee : 0.0;
        final total = Cart.subtotal + fee;

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              'My Cart',
              style:
                  TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: lines.isEmpty
              ? _emptyCart()
              : ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Items
                    _card('Items', [
                      for (final line in lines.values) _cartLine(line),
                    ]),
                    const SizedBox(height: 20),

                    // Collection or delivery
                    _card('How do you want to get it?', [
                      SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(
                              value: 'collect',
                              icon: Icon(Icons.storefront_outlined),
                              label: Text('Collect'),
                            ),
                            ButtonSegment(
                              value: 'delivery',
                              icon: Icon(Icons.local_shipping_outlined),
                              label: Text('Delivery'),
                            ),
                          ],
                          selected: {fulfilment},
                          showSelectedIcon: false,
                          onSelectionChanged: (s) =>
                              setState(() => fulfilment = s.first),
                        ),
                      ),
                      const SizedBox(height: 15),
                      if (fulfilment == 'collect')
                        _clinicPicker()
                      else
                        TextField(
                          controller: addressController,
                          maxLines: 2,
                          decoration: _decoration(
                            'Delivery address',
                            Icons.home_outlined,
                            helper:
                                'Delivery fee: ${formatRand(deliveryFee)}',
                          ),
                        ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: notesController,
                        maxLines: 2,
                        decoration: _decoration(
                          'Notes for the pharmacist (optional)',
                          Icons.edit_note,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 20),

                    // Totals
                    _card('Summary', [
                      _totalRow('Subtotal', formatRand(Cart.subtotal)),
                      if (fulfilment == 'delivery')
                        _totalRow('Delivery', formatRand(fee)),
                      const Divider(),
                      _totalRow('Total', formatRand(total), bold: true),
                      const SizedBox(height: 6),
                      const Text(
                        'You pay when you collect or receive your order.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ]),
                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isPlacing ? null : placeOrder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F80ED),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: isPlacing
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Place Order  •  ${formatRand(total)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _emptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.shopping_cart_outlined,
                size: 60, color: Colors.grey),
            const SizedBox(height: 15),
            const Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add medication from the Order Medication page.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Browse medication'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartLine(CartLine line) {
    final med = line.medication;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(med.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 3),
                Text(
                  '${formatRand(med.price)} each',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: line.quantity == 1 ? 'Remove' : 'Less',
            onPressed: () => Cart.setQuantity(med, line.quantity - 1),
            icon: Icon(
              line.quantity == 1 ? Icons.delete_outline : Icons.remove,
              size: 20,
            ),
          ),
          Text('${line.quantity}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: 'More',
            onPressed: line.quantity >= Cart.maxQuantity
                ? null
                : () => Cart.setQuantity(med, line.quantity + 1),
            icon: const Icon(Icons.add, size: 20),
          ),
          SizedBox(
            width: 80,
            child: Text(
              formatRand(line.lineTotal),
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _clinicPicker() {
    if (isLoadingClinics) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (clinicsError != null) {
      return Row(
        children: [
          Expanded(
            child: Text(clinicsError!,
                style: const TextStyle(color: Colors.grey)),
          ),
          TextButton(onPressed: loadClinics, child: const Text('Try again')),
        ],
      );
    }
    return DropdownButtonFormField<String>(
      initialValue: selectedClinicId,
      isExpanded: true,
      decoration: _decoration('Collect from', Icons.local_hospital_outlined),
      items: clinics
          .map((c) => DropdownMenuItem(
                value: c.id,
                child: Text('${c.name} (${c.municipality})',
                    overflow: TextOverflow.ellipsis),
              ))
          .toList(),
      onChanged: (id) => setState(() => selectedClinicId = id),
    );
  }

  Widget _totalRow(String label, String value, {bool bold = false}) {
    final style = TextStyle(
      fontSize: bold ? 17 : 15,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: style),
          const Spacer(),
          Text(value, style: style),
        ],
      ),
    );
  }

  Widget _card(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  InputDecoration _decoration(String label, IconData icon, {String? helper}) {
    return InputDecoration(
      labelText: label,
      helperText: helper,
      prefixIcon: Icon(icon, color: const Color(0xFF2F80ED)),
      filled: true,
      fillColor: Theme.of(context).scaffoldBackgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
