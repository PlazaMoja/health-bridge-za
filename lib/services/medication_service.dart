import '../dataconnect_generated/generated.dart';
import 'account_service.dart';

/// 45 -> "R45.00"
String formatRand(double amount) => 'R${amount.toStringAsFixed(2)}';

class Medication {
  final String id;
  final String name;
  final String type;
  final String category;
  final double price; // rand

  const Medication({
    required this.id,
    required this.name,
    required this.type,
    required this.category,
    required this.price,
  });
}

class OrderLine {
  final String name;
  final int quantity;
  final double unitPrice;
  final double lineTotal;

  const OrderLine(this.name, this.quantity, this.unitPrice, this.lineTotal);
}

class MedicationOrder {
  final String id;
  final List<OrderLine> items;
  final String fulfilment; // 'collect' or 'delivery'
  final String clinicName;
  final String deliveryAddress;
  final String notes;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String status; // 'pending', 'ready', 'completed', 'cancelled'
  final DateTime? placedAt;

  const MedicationOrder({
    required this.id,
    required this.items,
    required this.fulfilment,
    required this.clinicName,
    required this.deliveryAddress,
    required this.notes,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.status,
    required this.placedAt,
  });
}

/// Medications, placing orders and the user's order history (Data Connect).
class MedicationService {
  static const deliveryFee = 35.0;
  static const maxQuantity = 10;

  final HealthbridgeConnector _connector = HealthbridgeConnector.instance;
  final AccountService _account = AccountService();

  Future<List<Medication>> medications() async {
    final result = await _connector.listMedications().execute();
    return result.data.medications
        .map((m) => Medication(
              id: m.id,
              name: m.name,
              type: m.type ?? '',
              category: m.category,
              price: m.price,
            ))
        .toList();
  }

  Future<List<MedicationOrder>> myOrders() async {
    final ids = await _account.ids();
    final result =
        await _connector.listMedicationOrders(patientId: ids.patientId).execute();
    return result.data.medicationOrders
        .map((o) => MedicationOrder(
              id: o.id,
              items: o.medicationOrderItems_on_order
                  .map((i) =>
                      OrderLine(i.name, i.quantity, i.unitPrice, i.lineTotal))
                  .toList(),
              fulfilment: o.fulfilment,
              clinicName: o.clinic?.name ?? '',
              deliveryAddress: o.deliveryAddress ?? '',
              notes: o.notes ?? '',
              subtotal: o.subtotal,
              deliveryFee: o.deliveryFee,
              total: o.total,
              status: o.status,
              placedAt: o.createdAt?.toDateTime().toLocal(),
            ))
        .toList();
  }

  /// [quantities] maps each medication to how many.
  /// For 'collect' pass [clinicId]; for 'delivery' pass [deliveryAddress].
  Future<void> placeOrder({
    required Map<Medication, int> quantities,
    required String fulfilment,
    String? clinicId,
    String? deliveryAddress,
    String? notes,
  }) async {
    if (quantities.isEmpty) throw Exception('Your cart is empty.');
    if (fulfilment == 'collect' && (clinicId == null || clinicId.isEmpty)) {
      throw Exception('Please choose a clinic to collect from.');
    }
    if (fulfilment == 'delivery' &&
        (deliveryAddress == null || deliveryAddress.trim().length < 5)) {
      throw Exception('Please enter your full delivery address.');
    }
    for (final q in quantities.values) {
      if (q < 1 || q > maxQuantity) {
        throw Exception('Quantities must be between 1 and $maxQuantity.');
      }
    }

    double round(double v) => (v * 100).roundToDouble() / 100;
    final subtotal = round(quantities.entries
        .fold(0.0, (sum, e) => sum + e.key.price * e.value));
    final fee = fulfilment == 'delivery' ? deliveryFee : 0.0;
    final ids = await _account.ids();

    var insert = _connector.insertMedicationOrder(
      patientId: ids.patientId,
      fulfilment: fulfilment,
      subtotal: subtotal,
      deliveryFee: fee,
      total: round(subtotal + fee),
    );
    if (fulfilment == 'collect') insert = insert.clinicId(clinicId);
    if (fulfilment == 'delivery') {
      insert = insert.deliveryAddress(deliveryAddress!.trim());
    }
    final trimmedNotes = notes?.trim() ?? '';
    if (trimmedNotes.isNotEmpty) insert = insert.notes(trimmedNotes);

    final orderId = (await insert.execute()).data.medicationOrder_insert.id;

    try {
      for (final entry in quantities.entries) {
        final med = entry.key;
        await _connector
            .insertMedicationOrderItem(
              orderId: orderId,
              medicationId: med.id,
              name: med.name,
              quantity: entry.value,
              unitPrice: med.price,
              lineTotal: round(med.price * entry.value),
            )
            .execute();
      }
    } catch (_) {
      // Don't leave a half-saved order looking like a real one.
      await _connector.cancelMedicationOrder(id: orderId).execute();
      rethrow;
    }
  }

  Future<void> cancelOrder(String orderId) async {
    await _connector.cancelMedicationOrder(id: orderId).execute();
  }
}
