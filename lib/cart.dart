import 'package:flutter/foundation.dart';

import 'services/medication_service.dart';

/// One medication in the cart and how many of it.
class CartLine {
  final Medication medication;
  final int quantity;

  const CartLine(this.medication, this.quantity);

  double get lineTotal => medication.price * quantity;
}

/// The medication cart. It lives in memory while the app is open and is
/// emptied when the user logs out or places an order.
/// Screens listen to [lines] so they update when something is added.
class Cart {
  static const maxQuantity = MedicationService.maxQuantity;

  /// Medication ID -> cart line, in the order they were added.
  static final ValueNotifier<Map<String, CartLine>> lines = ValueNotifier({});

  static int quantityOf(String medicationId) =>
      lines.value[medicationId]?.quantity ?? 0;

  static int get itemCount =>
      lines.value.values.fold(0, (sum, line) => sum + line.quantity);

  static double get subtotal =>
      lines.value.values.fold(0.0, (sum, line) => sum + line.lineTotal);

  /// Sets how many of [medication] are in the cart. 0 removes it.
  static void setQuantity(Medication medication, int quantity) {
    final updated = Map<String, CartLine>.from(lines.value);
    if (quantity <= 0) {
      updated.remove(medication.id);
    } else {
      updated[medication.id] = CartLine(
          medication, quantity > maxQuantity ? maxQuantity : quantity);
    }
    lines.value = updated;
  }

  static void clear() {
    lines.value = {};
  }
}
