part of 'generated.dart';

class InsertAppointmentVariablesBuilder {
  String patientId;
  String clinicId;
  String serviceId;
  Optional<String> _healthcareWorkerId = Optional.optional(nativeFromJson, nativeToJson);
  DateTime appointmentDate;
  String startTime;
  Optional<String> _endTime = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _reason = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  InsertAppointmentVariablesBuilder healthcareWorkerId(String? t) {
   _healthcareWorkerId.value = t;
   return this;
  }
  InsertAppointmentVariablesBuilder endTime(String? t) {
   _endTime.value = t;
   return this;
  }
  InsertAppointmentVariablesBuilder reason(String? t) {
   _reason.value = t;
   return this;
  }

  InsertAppointmentVariablesBuilder(this._dataConnect, {required  this.patientId,required  this.clinicId,required  this.serviceId,required  this.appointmentDate,required  this.startTime,});
  Deserializer<InsertAppointmentData> dataDeserializer = (dynamic json)  => InsertAppointmentData.fromJson(jsonDecode(json));
  Serializer<InsertAppointmentVariables> varsSerializer = (InsertAppointmentVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertAppointmentData, InsertAppointmentVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertAppointmentData, InsertAppointmentVariables> ref() {
    InsertAppointmentVariables vars= InsertAppointmentVariables(patientId: patientId,clinicId: clinicId,serviceId: serviceId,healthcareWorkerId: _healthcareWorkerId,appointmentDate: appointmentDate,startTime: startTime,endTime: _endTime,reason: _reason,);
    return _dataConnect.mutation("InsertAppointment", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertAppointmentAppointmentInsert {
  final String id;
  InsertAppointmentAppointmentInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertAppointmentAppointmentInsert otherTyped = other as InsertAppointmentAppointmentInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertAppointmentAppointmentInsert({
    required this.id,
  });
}

@immutable
class InsertAppointmentData {
  final InsertAppointmentAppointmentInsert appointment_insert;
  InsertAppointmentData.fromJson(dynamic json):
  
  appointment_insert = InsertAppointmentAppointmentInsert.fromJson(json['appointment_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertAppointmentData otherTyped = other as InsertAppointmentData;
    return appointment_insert == otherTyped.appointment_insert;
    
  }
  @override
  int get hashCode => appointment_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['appointment_insert'] = appointment_insert.toJson();
    return json;
  }

  InsertAppointmentData({
    required this.appointment_insert,
  });
}

@immutable
class InsertAppointmentVariables {
  final String patientId;
  final String clinicId;
  final String serviceId;
  late final Optional<String>healthcareWorkerId;
  final DateTime appointmentDate;
  final String startTime;
  late final Optional<String>endTime;
  late final Optional<String>reason;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertAppointmentVariables.fromJson(Map<String, dynamic> json):
  
  patientId = nativeFromJson<String>(json['patientId']),
  clinicId = nativeFromJson<String>(json['clinicId']),
  serviceId = nativeFromJson<String>(json['serviceId']),
  appointmentDate = nativeFromJson<DateTime>(json['appointmentDate']),
  startTime = nativeFromJson<String>(json['startTime']) {
  
  
  
  
  
    healthcareWorkerId = Optional.optional(nativeFromJson, nativeToJson);
    healthcareWorkerId.value = json['healthcareWorkerId'] == null ? null : nativeFromJson<String>(json['healthcareWorkerId']);
  
  
  
  
    endTime = Optional.optional(nativeFromJson, nativeToJson);
    endTime.value = json['endTime'] == null ? null : nativeFromJson<String>(json['endTime']);
  
  
    reason = Optional.optional(nativeFromJson, nativeToJson);
    reason.value = json['reason'] == null ? null : nativeFromJson<String>(json['reason']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertAppointmentVariables otherTyped = other as InsertAppointmentVariables;
    return patientId == otherTyped.patientId && 
    clinicId == otherTyped.clinicId && 
    serviceId == otherTyped.serviceId && 
    healthcareWorkerId == otherTyped.healthcareWorkerId && 
    appointmentDate == otherTyped.appointmentDate && 
    startTime == otherTyped.startTime && 
    endTime == otherTyped.endTime && 
    reason == otherTyped.reason;
    
  }
  @override
  int get hashCode => Object.hashAll([patientId.hashCode, clinicId.hashCode, serviceId.hashCode, healthcareWorkerId.hashCode, appointmentDate.hashCode, startTime.hashCode, endTime.hashCode, reason.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['patientId'] = nativeToJson<String>(patientId);
    json['clinicId'] = nativeToJson<String>(clinicId);
    json['serviceId'] = nativeToJson<String>(serviceId);
    if(healthcareWorkerId.state == OptionalState.set) {
      json['healthcareWorkerId'] = healthcareWorkerId.toJson();
    }
    json['appointmentDate'] = nativeToJson<DateTime>(appointmentDate);
    json['startTime'] = nativeToJson<String>(startTime);
    if(endTime.state == OptionalState.set) {
      json['endTime'] = endTime.toJson();
    }
    if(reason.state == OptionalState.set) {
      json['reason'] = reason.toJson();
    }
    return json;
  }

  InsertAppointmentVariables({
    required this.patientId,
    required this.clinicId,
    required this.serviceId,
    required this.healthcareWorkerId,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.reason,
  });
}

