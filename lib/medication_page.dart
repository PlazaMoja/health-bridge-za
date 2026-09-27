import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models.dart';
import 'widgets/load_state.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  // Medications now come from the database (via the backend),
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
      final result = await ApiService.getMedications();
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
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.message;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMedication = medications[selectedCategory] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      // App Bar
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

          // Medication List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: availableMedication.length,
              itemBuilder: (context, index) {
                final medication = availableMedication[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [

                      // Medication Icon
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

                      // Medication Information
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
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
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Order Button
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  'Order Medication',
                                ),
                                content: Text(
                                  'You selected ${medication.name}. '
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

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${medication.name} added to order.',
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
              },
            ),
          ),
        ],
      ),
    );
  }
}