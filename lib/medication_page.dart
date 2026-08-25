import 'package:flutter/material.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  String selectedCategory = 'Headache & Pain';

  final Map<String, List<Map<String, String>>> medications = {
    'Headache & Pain': [
      {
        'name': 'Paracetamol',
        'type': 'Pain and fever relief',
      },
      {
        'name': 'Ibuprofen',
        'type': 'Pain and inflammation relief',
      },
      {
        'name': 'Aspirin',
        'type': 'Pain and fever relief',
      },
      {
        'name': 'Diclofenac',
        'type': 'Pain and inflammation relief',
      },
      {
        'name': 'Topical pain relief gel',
        'type': 'Local muscle and joint pain relief',
      },
    ],

    'Cough & Cold': [
      {
        'name': 'Saline nasal spray',
        'type': 'Helps relieve blocked or dry nose',
      },
      {
        'name': 'Guaifenesin',
        'type': 'Expectorant for mucus',
      },
      {
        'name': 'Dextromethorphan',
        'type': 'Cough suppressant',
      },
      {
        'name': 'Menthol lozenges',
        'type': 'Soothes throat irritation',
      },
      {
        'name': 'Honey-based cough mixture',
        'type': 'Soothes cough and throat irritation',
      },
    ],

    'Allergies': [
      {
        'name': 'Loratadine',
        'type': 'Antihistamine',
      },
      {
        'name': 'Cetirizine',
        'type': 'Antihistamine',
      },
      {
        'name': 'Chlorphenamine',
        'type': 'Antihistamine',
      },
      {
        'name': 'Saline nasal spray',
        'type': 'Helps rinse allergens from the nose',
      },
      {
        'name': 'Allergy eye drops',
        'type': 'Helps relieve itchy or watery eyes',
      },
    ],

    'Diarrhoea & Dehydration': [
      {
        'name': 'Oral rehydration solution',
        'type': 'Replaces fluids and electrolytes',
      },
      {
        'name': 'Oral rehydration salts',
        'type': 'Helps prevent dehydration',
      },
      {
        'name': 'Zinc supplements',
        'type': 'May be used in some diarrhoeal illnesses',
      },
      {
        'name': 'Loperamide',
        'type': 'Symptom relief for some types of diarrhoea',
      },
      {
        'name': 'Electrolyte solution',
        'type': 'Replaces lost fluids and electrolytes',
      },
    ],

    'Heartburn & Indigestion': [
      {
        'name': 'Calcium carbonate',
        'type': 'Antacid',
      },
      {
        'name': 'Magnesium hydroxide',
        'type': 'Antacid',
      },
      {
        'name': 'Aluminium hydroxide',
        'type': 'Antacid',
      },
      {
        'name': 'Omeprazole',
        'type': 'Reduces stomach acid',
      },
      {
        'name': 'Famotidine',
        'type': 'Reduces stomach acid',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final availableMedication = medications[selectedCategory]!;

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

      body: Column(
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
                              medication['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              medication['type']!,
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

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
              },
            ),
          ),
        ],
      ),
    );
  }
}