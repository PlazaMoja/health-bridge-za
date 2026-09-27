import 'package:flutter/material.dart';
import 'services/app_error.dart';
import 'services/sql_service.dart';

class ConsultPage extends StatefulWidget {
  const ConsultPage({super.key});

  @override
  State<ConsultPage> createState() => _ConsultPageState();
}

class _ConsultPageState extends State<ConsultPage> {
  final SqlService _sql = SqlService();
  late Future<List<dynamic>> _workers;

  @override
  void initState() {
    super.initState();
    _workers = _sql.allHealthcareWorkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Talk to a Doctor')),
      body: FutureBuilder<List<dynamic>>(
        future: _workers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Unable to load doctors.\n${AppError.message(snapshot.error!)}', textAlign: TextAlign.center));
          }
          final workers = snapshot.data!;
          if (workers.isEmpty) return const Center(child: Text('No doctors available'));
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: workers.length,
            itemBuilder: (context, index) {
              final worker = workers[index];
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text('${worker.user.firstName} ${worker.user.lastName}'),
                  subtitle: Text(worker.specialization ?? worker.profession ?? 'General Practitioner'),
                  trailing: FilledButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Consultation request started.')),
                    ),
                    child: const Text('Talk'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
