library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'insert_appointment.dart';

part 'update_appointment.dart';

part 'insert_consultation_request.dart';

part 'cancel_consultation_request.dart';

part 'insert_medication_order.dart';

part 'insert_medication_order_item.dart';

part 'cancel_medication_order.dart';

part 'insert_patient.dart';

part 'update_user_details.dart';

part 'update_patient_details.dart';

part 'insert_preference.dart';

part 'update_preference.dart';

part 'delete_patient_account.dart';

part 'insert_user.dart';

part 'list_clinics.dart';

part 'list_healthcare_workers.dart';

part 'list_services.dart';

part 'list_appointments.dart';

part 'list_medical_records.dart';

part 'list_all_healthcare_workers.dart';

part 'list_consultation_requests.dart';

part 'list_medications.dart';

part 'list_medication_orders.dart';

part 'get_patient_profile.dart';

part 'get_preference.dart';

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
  
  
  InsertConsultationRequestVariablesBuilder insertConsultationRequest ({required String patientId, required String healthcareWorkerId, required String reason, required DateTime preferredDate, required String preferredTime, required String mode, }) {
    return InsertConsultationRequestVariablesBuilder(dataConnect, patientId: patientId,healthcareWorkerId: healthcareWorkerId,reason: reason,preferredDate: preferredDate,preferredTime: preferredTime,mode: mode,);
  }
  
  
  CancelConsultationRequestVariablesBuilder cancelConsultationRequest ({required String id, }) {
    return CancelConsultationRequestVariablesBuilder(dataConnect, id: id,);
  }
  
  
  InsertMedicationOrderVariablesBuilder insertMedicationOrder ({required String patientId, required String fulfilment, required double subtotal, required double deliveryFee, required double total, }) {
    return InsertMedicationOrderVariablesBuilder(dataConnect, patientId: patientId,fulfilment: fulfilment,subtotal: subtotal,deliveryFee: deliveryFee,total: total,);
  }
  
  
  InsertMedicationOrderItemVariablesBuilder insertMedicationOrderItem ({required String orderId, required String medicationId, required String name, required int quantity, required double unitPrice, required double lineTotal, }) {
    return InsertMedicationOrderItemVariablesBuilder(dataConnect, orderId: orderId,medicationId: medicationId,name: name,quantity: quantity,unitPrice: unitPrice,lineTotal: lineTotal,);
  }
  
  
  CancelMedicationOrderVariablesBuilder cancelMedicationOrder ({required String id, }) {
    return CancelMedicationOrderVariablesBuilder(dataConnect, id: id,);
  }
  
  
  InsertPatientVariablesBuilder insertPatient ({required String userId, }) {
    return InsertPatientVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  UpdateUserDetailsVariablesBuilder updateUserDetails ({required String id, required String firstName, required String lastName, }) {
    return UpdateUserDetailsVariablesBuilder(dataConnect, id: id,firstName: firstName,lastName: lastName,);
  }
  
  
  UpdatePatientDetailsVariablesBuilder updatePatientDetails ({required String id, }) {
    return UpdatePatientDetailsVariablesBuilder(dataConnect, id: id,);
  }
  
  
  InsertPreferenceVariablesBuilder insertPreference ({required String userId, }) {
    return InsertPreferenceVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  UpdatePreferenceVariablesBuilder updatePreference ({required String id, }) {
    return UpdatePreferenceVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeletePatientAccountVariablesBuilder deletePatientAccount ({required String userId, required String patientId, }) {
    return DeletePatientAccountVariablesBuilder(dataConnect, userId: userId,patientId: patientId,);
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
  
  
  ListConsultationRequestsVariablesBuilder listConsultationRequests ({required String patientId, }) {
    return ListConsultationRequestsVariablesBuilder(dataConnect, patientId: patientId,);
  }
  
  
  ListMedicationsVariablesBuilder listMedications () {
    return ListMedicationsVariablesBuilder(dataConnect, );
  }
  
  
  ListMedicationOrdersVariablesBuilder listMedicationOrders ({required String patientId, }) {
    return ListMedicationOrdersVariablesBuilder(dataConnect, patientId: patientId,);
  }
  
  
  GetPatientProfileVariablesBuilder getPatientProfile ({required String userId, }) {
    return GetPatientProfileVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  GetPreferenceVariablesBuilder getPreference ({required String userId, }) {
    return GetPreferenceVariablesBuilder(dataConnect, userId: userId,);
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
