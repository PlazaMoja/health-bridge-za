import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models.dart';
import 'widgets/load_state.dart';

class ClinicsPage extends StatefulWidget {
  const ClinicsPage({super.key});

  @override
  State<ClinicsPage> createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  final TextEditingController searchController = TextEditingController();

  // Clinics now come from the database (via the backend)
  List<Clinic> clinics = [];
  List<Clinic> filteredClinics = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadClinics();
  }

  Future<void> loadClinics() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await ApiService.getClinics();
      if (!mounted) return;
      setState(() {
        clinics = result;
        filteredClinics = result;
        isLoading = false;
      });
      if (searchController.text.isNotEmpty) {
        searchClinics(searchController.text);
      }
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.message;
        isLoading = false;
      });
    }
  }

  // Search Clinics
  void searchClinics(String query) {
    setState(() {
      filteredClinics = clinics.where((clinic) {
        final name = clinic.name.toLowerCase();
        final address = clinic.address.toLowerCase();
        final search = query.toLowerCase();

        return name.contains(search) ||
            address.contains(search);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Nearby Clinics',
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

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: searchController,
              onChanged: searchClinics,
              decoration: InputDecoration(
                hintText: 'Search clinics...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF2F80ED),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Clinic List
          Expanded(
            child: isLoading || errorMessage != null
                ? LoadState(
                    isLoading: isLoading,
                    errorMessage: errorMessage,
                    onRetry: loadClinics,
                  )
                : filteredClinics.isEmpty
                ? const Center(
                    child: Text(
                      'No clinics found.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredClinics.length,
              itemBuilder: (context, index) {
                final clinic = filteredClinics[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Clinic Name
                      Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF4FF),
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.local_hospital,
                              color: Color(0xFF2F80ED),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              clinic.name,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // Address
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              clinic.address,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Distance
                      Row(
                        children: [
                          const Icon(
                            Icons.directions_walk,
                            size: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            clinic.distance,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // Availability
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: clinic.availability ==
                                      'Available'
                                  ? Colors.green.shade50
                                  : Colors.orange.shade50,
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                            child: Text(
                              clinic.availability,
                              style: TextStyle(
                                color: clinic.availability ==
                                        'Available'
                                    ? Colors.green
                                    : Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          // Select Clinic
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${clinic.name} selected.',
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF2F80ED),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Select Clinic',
                            ),
                          ),
                        ],
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