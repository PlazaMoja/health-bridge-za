import 'package:flutter/material.dart';

import 'services/app_error.dart';
import 'services/consultation_service.dart';
import 'widgets/load_state.dart';

/// Talk to a Doctor > My consultations. Requests can be cancelled until
/// the clinic confirms them.
class ConsultationsPage extends StatefulWidget {
  const ConsultationsPage({super.key});

  @override
  State<ConsultationsPage> createState() => _ConsultationsPageState();
}

class _ConsultationsPageState extends State<ConsultationsPage> {
  final service = ConsultationService();
  List<Consultation> consultations = [];
  bool isLoading = true;
  String? errorMessage;
  String? cancellingId;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load({bool showSpinner = true}) async {
    setState(() {
      isLoading = showSpinner;
      errorMessage = null;
    });
    try {
      final result = await service.mine();
      if (!mounted) return;
      setState(() {
        consultations = result;
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

  Future<void> cancel(Consultation c) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cancel request?'),
        content: Text('Cancel your consultation request with ${c.doctorName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Keep it'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Cancel request'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => cancellingId = c.id);
    try {
      await service.cancel(c.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request cancelled.')),
      );
      await load(showSpinner: false);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppError.message(e))),
      );
    } finally {
      if (mounted) setState(() => cancellingId = null);
    }
  }

  String statusLabel(String status) =>
      status.isEmpty ? status : status[0].toUpperCase() + status.substring(1);

  Color statusColor(String status) {
    switch (status) {
      case 'requested':
        return const Color(0xFFF2A100);
      case 'confirmed':
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
      appBar: AppBar(title: const Text('My Consultations')),
      body: isLoading || errorMessage != null
          ? LoadState(
              isLoading: isLoading,
              errorMessage: errorMessage,
              onRetry: load,
            )
          : RefreshIndicator(
              onRefresh: () => load(showSpinner: false),
              child: consultations.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 120),
                        Icon(Icons.event_note_outlined,
                            size: 60, color: Colors.grey),
                        SizedBox(height: 15),
                        Center(
                          child: Text(
                            'No consultation requests yet',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: consultations.length,
                      itemBuilder: (context, index) =>
                          _card(consultations[index]),
                    ),
            ),
    );
  }

  Widget _card(Consultation c) {
    final color = statusColor(c.status);
    final d = c.preferredDate;
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
          Row(
            children: [
              Icon(
                c.mode == 'video'
                    ? Icons.videocam_outlined
                    : Icons.phone_outlined,
                color: const Color(0xFF2F80ED),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  c.doctorName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
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
                  statusLabel(c.status),
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            [c.specialty, c.clinicName].where((s) => s.isNotEmpty).join(' · '),
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            '${c.mode == 'video' ? 'Video call' : 'Phone call'} · '
            '${d.day}/${d.month}/${d.year} · '
            '${ConsultationService.times[c.preferredTime] ?? c.preferredTime}',
          ),
          const SizedBox(height: 6),
          Text('“${c.reason}”'),
          if (c.clinicPhone.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text('Clinic: ${c.clinicPhone}',
                style: const TextStyle(color: Colors.grey)),
          ],
          if (c.status == 'requested') ...[
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: cancellingId == c.id ? null : () => cancel(c),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                icon: const Icon(Icons.close, size: 18),
                label: const Text('Cancel request'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
