import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'services/app_error.dart';
import 'services/sql_service.dart';
import 'appointment_page.dart';

/// Clinics sorted nearest first when the user shares their location,
/// otherwise A–Z. Distances use each clinic's latitude/longitude.
class ClinicsPage extends StatefulWidget {
  const ClinicsPage({super.key});

  @override
  State<ClinicsPage> createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  final SqlService _sql = SqlService();
  final TextEditingController _search = TextEditingController();
  late Future<List<dynamic>> _clinics;

  Position? _position;
  bool _locating = false;
  String? _locationNote;

  @override
  void initState() {
    super.initState();
    _clinics = _sql.clinics();
    _locate();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  /// Asks for the user's location (the browser or phone shows its own prompt).
  Future<void> _locate() async {
    setState(() {
      _locating = true;
      _locationNote = null;
    });
    String? note;
    Position? position;
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        note = 'Turn on location to see the nearest clinics first.';
      } else {
        var permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          note = 'Location not allowed, so clinics are listed A–Z.';
        } else {
          position = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.medium,
              timeLimit: Duration(seconds: 15),
            ),
          );
        }
      }
    } catch (_) {
      note = "Couldn't get your location, so clinics are listed A–Z.";
    }
    if (!mounted) return;
    setState(() {
      _locating = false;
      _position = position;
      _locationNote = note;
    });
  }

  /// Metres from the user to the clinic, or null if either location is unknown.
  double? _distanceTo(dynamic clinic) {
    final p = _position;
    final lat = clinic.latitude as double?;
    final lng = clinic.longitude as double?;
    if (p == null || lat == null || lng == null) return null;
    return Geolocator.distanceBetween(p.latitude, p.longitude, lat, lng);
  }

  String _formatDistance(double metres) => metres < 1000
      ? '${metres.round()} m away'
      : '${(metres / 1000).toStringAsFixed(metres < 10000 ? 1 : 0)} km away';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Clinics'),
        actions: [
          IconButton(
            tooltip: 'Update my location',
            onPressed: _locating ? null : _locate,
            icon: const Icon(Icons.my_location),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: TextField(
              controller: _search,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Search clinics...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          _locationBar(),
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
                      clinic.municipality.toLowerCase().contains(query) ||
                      (clinic.address?.toLowerCase().contains(query) ?? false);
                }).toList();

                // Nearest first; clinics without a location go last, A–Z.
                clinics.sort((a, b) {
                  final da = _distanceTo(a);
                  final db = _distanceTo(b);
                  if (da != null && db != null) return da.compareTo(db);
                  if (da != null) return -1;
                  if (db != null) return 1;
                  return (a.name as String).compareTo(b.name as String);
                });

                if (clinics.isEmpty) {
                  return const Center(child: Text('No clinics found'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: clinics.length,
                  itemBuilder: (context, index) {
                    final clinic = clinics[index];
                    final distance = _distanceTo(clinic);
                    final hours = clinic.openingTime != null &&
                            clinic.closingTime != null
                        ? 'Open ${clinic.openingTime}–${clinic.closingTime}'
                        : null;
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.local_hospital),
                        title: Text(clinic.name),
                        subtitle: Text(
                          [
                            [clinic.address, clinic.municipality]
                                .whereType<String>()
                                .join(', '),
                            if (hours != null) hours,
                          ].join('\n'),
                        ),
                        isThreeLine: hours != null,
                        trailing: distance == null
                            ? const Icon(Icons.chevron_right)
                            : Text(
                                _formatDistance(distance),
                                style: const TextStyle(
                                  color: Color(0xFF2F80ED),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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

  /// One line under the search box saying how the list is sorted.
  Widget _locationBar() {
    final String text;
    final IconData icon;
    if (_locating) {
      text = 'Finding your location…';
      icon = Icons.location_searching;
    } else if (_position != null) {
      text = 'Nearest clinics first';
      icon = Icons.near_me;
    } else {
      text = _locationNote ?? 'Clinics listed A–Z';
      icon = Icons.location_off_outlined;
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 12, 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: const TextStyle(color: Colors.grey)),
          ),
          if (!_locating && _position == null)
            TextButton(onPressed: _locate, child: const Text('Try again')),
        ],
      ),
    );
  }
}
