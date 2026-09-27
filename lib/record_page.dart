import 'package:flutter/material.dart';
import 'services/app_error.dart';
import 'services/sql_service.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  final SqlService _sql = SqlService();
  late Future<List<dynamic>> _records;

  @override
  void initState() {
    super.initState();
    _records = _sql.medicalRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Records')),
      body: FutureBuilder<List<dynamic>>(
        future: _records,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Unable to load health records.\n${AppError.message(snapshot.error!)}', textAlign: TextAlign.center));
          }
          final records = snapshot.data!;
          if (records.isEmpty) return const Center(child: Text('No medical records found'));
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: Text(record.diagnosis ?? 'Medical record'),
                  subtitle: Text('${record.clinic.name}\n${record.notes ?? ''}\nVisit: ${record.visitDate.day}/${record.visitDate.month}/${record.visitDate.year}'),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
