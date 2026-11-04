import 'package:flutter/material.dart';

import 'services/app_error.dart';
import 'services/medication_service.dart';
import 'widgets/load_state.dart';

/// The user's medication orders, newest first. Pending orders can be cancelled.
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<MedicationOrder> orders = [];
  bool isLoading = true;
  String? errorMessage;
  String? cancellingId;

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders({bool showSpinner = true}) async {
    setState(() {
      isLoading = showSpinner;
      errorMessage = null;
    });

    try {
      final result = await MedicationService().myOrders();
      if (!mounted) return;
      setState(() {
        orders = result;
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

  Future<void> cancel(MedicationOrder order) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cancel order?'),
        content: Text(
            'Cancel this order of ${order.items.length} item(s) for ${formatRand(order.total)}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Keep order'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Cancel order'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => cancellingId = order.id);
    try {
      await MedicationService().cancelOrder(order.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order cancelled.')),
      );
      await loadOrders(showSpinner: false);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppError.message(e))),
      );
    } finally {
      if (mounted) setState(() => cancellingId = null);
    }
  }

  // -> "3/11/2026  09:45"
  String displayDate(DateTime? date) {
    if (date == null) return '';
    final time = TimeOfDay.fromDateTime(date).format(context);
    return '${date.day}/${date.month}/${date.year}  $time';
  }

  // 'pending' -> 'Pending'
  String statusLabel(String status) => status.isEmpty
      ? status
      : status[0].toUpperCase() + status.substring(1);

  Color statusColor(String status) {
    switch (status) {
      case 'pending':
        return const Color(0xFFF2A100);
      case 'ready':
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'My Orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading || errorMessage != null
          ? LoadState(
              isLoading: isLoading,
              errorMessage: errorMessage,
              onRetry: loadOrders,
            )
          : RefreshIndicator(
              onRefresh: () => loadOrders(showSpinner: false),
              child: orders.isEmpty
                  ? ListView(
                      // A ListView so pull-to-refresh still works when empty.
                      children: const [
                        SizedBox(height: 120),
                        Icon(Icons.receipt_long_outlined,
                            size: 60, color: Colors.grey),
                        SizedBox(height: 15),
                        Center(
                          child: Text(
                            'No orders yet',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: orders.length,
                      itemBuilder: (context, index) =>
                          _orderCard(orders[index]),
                    ),
            ),
    );
  }

  Widget _orderCard(MedicationOrder order) {
    final color = statusColor(order.status);
    final isCollect = order.fulfilment == 'collect';

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date + status
          Row(
            children: [
              Expanded(
                child: Text(
                  displayDate(order.placedAt),
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusLabel(order.status),
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Items
          for (final item in order.items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Expanded(child: Text('${item.quantity} × ${item.name}')),
                  Text(formatRand(item.lineTotal)),
                ],
              ),
            ),
          const Divider(),

          // Collection / delivery
          Row(
            children: [
              Icon(
                isCollect
                    ? Icons.storefront_outlined
                    : Icons.local_shipping_outlined,
                size: 18,
                color: const Color(0xFF2F80ED),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isCollect
                      ? 'Collect at ${order.clinicName}'
                      : 'Deliver to ${order.deliveryAddress}',
                ),
              ),
            ],
          ),
          if (order.deliveryFee > 0) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Text('Delivery fee',
                    style: TextStyle(color: Colors.grey)),
                const Spacer(),
                Text(formatRand(order.deliveryFee),
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
          if (order.notes.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text('Note: ${order.notes}',
                style: const TextStyle(color: Colors.grey)),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Total',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Spacer(),
              Text(formatRand(order.total),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),

          if (order.status == 'pending') ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed:
                    cancellingId == order.id ? null : () => cancel(order),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                icon: const Icon(Icons.close, size: 18),
                label: const Text('Cancel order'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
