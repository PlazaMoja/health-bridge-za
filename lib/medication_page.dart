import 'package:flutter/material.dart';
import '../services/postgres_service.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  String selectedCategory = 'All';
  List<dynamic> medications = [];
  bool isLoading = true;
  String? errorMessage;

  final PostgresService _postgresService = PostgresService();

  @override
  void initState() {
    super.initState();
    _loadMedications();
  }

  Future<void> _loadMedications() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await _postgresService.getList('medications');
      setState(() {
        medications = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceAll('Exception: ', '');
        isLoading = false;
      });
    }
  }

  List<dynamic> get filteredMedications {
    if (selectedCategory == 'All') return medications;
    return medications.where((med) {
      final category = med['category']?.toString() ?? '';
      return category == selectedCategory;
    }).toList();
  }

  List<String> get categories {
    final cats = medications
        .map((med) => med['category']?.toString() ?? 'Other')
        .toSet()
        .toList();
    cats.sort();
    return ['All', ...cats];
  }

  Widget _buildMedicationItem(dynamic medication) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.medication_outlined,
              color: Color(0xFF2F80ED),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medication['name'] ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  medication['description'] ?? medication['type'] ?? '',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Order Medication'),
                    content: Text(
                      'You selected ${medication['name']}. '
                      'A pharmacist or healthcare professional '
                      'should confirm that it is appropriate '
                      'for you before purchase.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${medication['name']} added to order.',
                              ),
                            ),
                          );
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Order'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableMedications = filteredMedications;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Order Medication',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text('Error: $errorMessage'),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _loadMedications,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        children: categories.map((category) {
                          final isSelected = category == selectedCategory;

                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ChoiceChip(
                              label: Text(category),
                              selected: isSelected,
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

                    Expanded(
                      child: availableMedications.isEmpty
                          ? const Center(
                              child: Text('No medications found'),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(20),
                              itemCount: availableMedications.length,
                              itemBuilder: (context, index) {
                                return _buildMedicationItem(
                                    availableMedications[index]);
                              },
                            ),
                    ),
                  ],
                ),
    );
  }
}
