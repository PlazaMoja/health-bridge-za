library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'insert_appointment.dart';

part 'update_appointment.dart';

part 'insert_patient.dart';

part 'insert_user.dart';

part 'list_clinics.dart';

part 'list_healthcare_workers.dart';

part 'list_services.dart';

part 'list_appointments.dart';

part 'list_medical_records.dart';

part 'list_all_healthcare_workers.dart';

part 'get_user.dart';

part 'get_patient_by_user_id.dart';

part 'get_user_by_email.dart';







class HealthbridgeConnector {
  
  
  InsertAppointmentVariablesBuilder insertAppointment ({required String patientId, required String clinicId, required String serviceId, required DateTime appointmentDate, required String startTime, }) {
    return InsertAppointmentVariablesBuilder(dataConnect, patientId: patientId,clinicId: clinicId,serviceId: serviceId,appointmentDate: appointmentDate,startTime: startTime,);
  }
  
  
  UpdateAppointmentVariablesBuilder updateAppointment ({required String id, }) {
    return UpdateAppointmentVariablesBuilder(dataConnect, id: id,);
  }
  
  
  InsertPatientVariablesBuilder insertPatient ({required String userId, }) {
    return InsertPatientVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  InsertUserVariablesBuilder insertUser ({required String firebaseUid, required String email, required String firstName, required String lastName, }) {
    return InsertUserVariablesBuilder(dataConnect, firebaseUid: firebaseUid,email: email,firstName: firstName,lastName: lastName,);
  }
  
  
  ListClinicsVariablesBuilder listClinics () {
    return ListClinicsVariablesBuilder(dataConnect, );
  }
  
  
  ListHealthcareWorkersVariablesBuilder listHealthcareWorkers ({required String clinicId, }) {
    return ListHealthcareWorkersVariablesBuilder(dataConnect, clinicId: clinicId,);
  }
  
  
  ListServicesVariablesBuilder listServices ({required String clinicId, }) {
    return ListServicesVariablesBuilder(dataConnect, clinicId: clinicId,);
  }
  
  
  ListAppointmentsVariablesBuilder listAppointments ({required String patientId, }) {
    return ListAppointmentsVariablesBuilder(dataConnect, patientId: patientId,);
  }
  
  
  ListMedicalRecordsVariablesBuilder listMedicalRecords ({required String patientId, }) {
    return ListMedicalRecordsVariablesBuilder(dataConnect, patientId: patientId,);
  }
  
  
  ListAllHealthcareWorkersVariablesBuilder listAllHealthcareWorkers () {
    return ListAllHealthcareWorkersVariablesBuilder(dataConnect, );
  }
  
  
  GetUserVariablesBuilder getUser ({required String firebaseUid, }) {
    return GetUserVariablesBuilder(dataConnect, firebaseUid: firebaseUid,);
  }
  
  
  GetPatientByUserIdVariablesBuilder getPatientByUserId ({required String userId, }) {
    return GetPatientByUserIdVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  GetUserByEmailVariablesBuilder getUserByEmail ({required String email, }) {
    return GetUserByEmailVariablesBuilder(dataConnect, email: email,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-east4',
    'healthbridge',
    'health-28c44-service',
  );

  HealthbridgeConnector({required this.dataConnect});
  static HealthbridgeConnector get instance {
    
    CacheSettings cacheSettings = CacheSettings(
      maxAge: Duration(milliseconds:0),
      storage: CacheStorage.persistent,
    );
    
    return HealthbridgeConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            cacheSettings: cacheSettings,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
