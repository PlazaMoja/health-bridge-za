import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models.dart';
import 'session.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  String selectedDoctor = 'Select healthcare professional';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final TextEditingController reasonController = TextEditingController();

  // Healthcare Professionals now come from the database (via the backend)
  List<Doctor> doctors = [];
  bool isLoadingDoctors = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    loadDoctors();
  }

  Future<void> loadDoctors() async {
    setState(() => isLoadingDoctors = true);
    try {
      final result = await ApiService.getDoctors();
      if (!mounted) return;
      setState(() {
        doctors = result;
        isLoadingDoctors = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => isLoadingDoctors = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          action: SnackBarAction(label: 'Retry', onPressed: loadDoctors),
        ),
      );
    }
  }

  // Formats for the backend: date as yyyy-MM-dd, time as HH:mm (24-hour)
  String _two(int n) => n.toString().padLeft(2, '0');
  String get _dateForApi =>
      '${selectedDate!.year}-${_two(selectedDate!.month)}-${_two(selectedDate!.day)}';
  String get _timeForApi =>
      '${_two(selectedTime!.hour)}:${_two(selectedTime!.minute)}';

  // Select Date
  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // Select Time
  Future<void> selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }


  // Confirm Appointment
Future<void> confirmAppointment() async {
  if (selectedDoctor == 'Select healthcare professional') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select a healthcare professional.'),
      ),
    );
    return;
  }

  if (reasonController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter the reason for your visit.'),
      ),
    );
    return;
  }

  if (selectedDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select an appointment date.'),
      ),
    );
    return;
  }

  if (selectedTime == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select an appointment time.'),
      ),
    );
    return;
  }

  final user = Session.currentUser;
  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please log in again.'),
      ),
    );
    return;
  }

  final doctor = doctors.firstWhere((d) => d.name == selectedDoctor);

  // Save the appointment in the database
  setState(() => isSaving = true);
  try {
    await ApiService.bookAppointment(
      userId: user.id,
      doctor: doctor,
      reason: reasonController.text.trim(),
      date: _dateForApi,
      time: _timeForApi,
    );
  } on ApiException catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.message)),
    );
    return;
  } finally {
    if (mounted) setState(() => isSaving = false);
  }

  if (!mounted) return;

  // Appointment Confirmed
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Appointment Confirmed'),

        content: Text(
          'Your appointment with $selectedDoctor '
          'has been booked successfully.',
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

  @override
  void dispose() {
    reasonController.dispose();
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
          'Book Appointment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Healthcare Professional
            const Text(
              'Healthcare Professional',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedDoctor,
                  isExpanded: true,
                  items: [
                    const DropdownMenuItem(
                      value: 'Select healthcare professional',
                      child: Text(
                        'Select healthcare professional',
                      ),
                    ),
                    ...doctors.map(
                      (doctor) => DropdownMenuItem(
                        value: doctor.name,
                        child: Text(doctor.name),
                      ),
                    ),
                  ],
                  onChanged: isLoadingDoctors
                      ? null
                      : (value) {
                    setState(() {
                      selectedDoctor = value!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Next Available Appointment
            const Text(
              'Next Available Appointment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF4FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Color(0xFF2F80ED),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Next available: Tomorrow at 10:00 AM',
                    style: TextStyle(
                      color: Color(0xFF2F80ED),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Reason for Visit
            const Text(
              'Reason for Visit',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: reasonController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter reason for your appointment',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Date
            const Text(
              'Date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            InkWell(
              onTap: selectDate,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: Color(0xFF2F80ED),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      selectedDate == null
                          ? 'Select date'
                          : '${selectedDate!.day}/'
                              '${selectedDate!.month}/'
                              '${selectedDate!.year}',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Time
            const Text(
              'Time',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            InkWell(
              onTap: selectTime,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Color(0xFF2F80ED),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      selectedTime == null
                          ? 'Select time'
                          : selectedTime!.format(context),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),

            // Confirm Appointment
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isSaving ? null : confirmAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F80ED),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFF2F80ED),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isSaving
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Confirm Appointment',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}