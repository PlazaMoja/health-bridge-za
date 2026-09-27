import 'package:flutter/material.dart';
import 'services/app_error.dart';
import 'services/sql_service.dart';
import 'appointment_page.dart';

class ClinicsPage extends StatefulWidget {
  const ClinicsPage({super.key});

  @override
  State<ClinicsPage> createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  final SqlService _sql = SqlService();
  final TextEditingController _search = TextEditingController();
  late Future<List<dynamic>> _clinics;

  @override
  void initState() {
    super.initState();
    _clinics = _sql.clinics();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Clinics')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _search,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Search clinics...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _clinics,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Unable to load clinics.\n${AppError.message(snapshot.error!)}',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                final query = _search.text.trim().toLowerCase();
                final clinics = snapshot.data!.where((clinic) {
                  return clinic.name.toLowerCase().contains(query) ||
                      clinic.province.toLowerCase().contains(query) ||
                      (clinic.address?.toLowerCase().contains(query) ?? false);
                }).toList();
                if (clinics.isEmpty) {
                  return const Center(child: Text('No clinics found'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: clinics.length,
                  itemBuilder: (context, index) {
                    final clinic = clinics[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.local_hospital),
                        title: Text(clinic.name),
                        subtitle: Text(
                          [clinic.address, clinic.province]
                              .whereType<String>()
                              .join(', '),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AppointmentPage(clinicId: clinic.id),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
