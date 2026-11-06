part of 'generated.dart';

class InsertConsultationRequestVariablesBuilder {
  String patientId;
  String healthcareWorkerId;
  String reason;
  DateTime preferredDate;
  String preferredTime;
  String mode;

  final FirebaseDataConnect _dataConnect;
  InsertConsultationRequestVariablesBuilder(this._dataConnect, {required  this.patientId,required  this.healthcareWorkerId,required  this.reason,required  this.preferredDate,required  this.preferredTime,required  this.mode,});
  Deserializer<InsertConsultationRequestData> dataDeserializer = (dynamic json)  => InsertConsultationRequestData.fromJson(jsonDecode(json));
  Serializer<InsertConsultationRequestVariables> varsSerializer = (InsertConsultationRequestVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertConsultationRequestData, InsertConsultationRequestVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertConsultationRequestData, InsertConsultationRequestVariables> ref() {
    InsertConsultationRequestVariables vars= InsertConsultationRequestVariables(patientId: patientId,healthcareWorkerId: healthcareWorkerId,reason: reason,preferredDate: preferredDate,preferredTime: preferredTime,mode: mode,);
    return _dataConnect.mutation("InsertConsultationRequest", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertConsultationRequestConsultationRequestInsert {
  final String id;
  InsertConsultationRequestConsultationRequestInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertConsultationRequestConsultationRequestInsert otherTyped = other as InsertConsultationRequestConsultationRequestInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertConsultationRequestConsultationRequestInsert({
    required this.id,
  });
}

@immutable
class InsertConsultationRequestData {
  final InsertConsultationRequestConsultationRequestInsert consultationRequest_insert;
  InsertConsultationRequestData.fromJson(dynamic json):
  
  consultationRequest_insert = InsertConsultationRequestConsultationRequestInsert.fromJson(json['consultationRequest_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertConsultationRequestData otherTyped = other as InsertConsultationRequestData;
    return consultationRequest_insert == otherTyped.consultationRequest_insert;
    
  }
  @override
  int get hashCode => consultationRequest_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['consultationRequest_insert'] = consultationRequest_insert.toJson();
    return json;
  }

  InsertConsultationRequestData({
    required this.consultationRequest_insert,
  });
}

@immutable
class InsertConsultationRequestVariables {
  final String patientId;
  final String healthcareWorkerId;
  final String reason;
  final DateTime preferredDate;
  final String preferredTime;
  final String mode;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertConsultationRequestVariables.fromJson(Map<String, dynamic> json):
  
  patientId = nativeFromJson<String>(json['patientId']),
  healthcareWorkerId = nativeFromJson<String>(json['healthcareWorkerId']),
  reason = nativeFromJson<String>(json['reason']),
  preferredDate = nativeFromJson<DateTime>(json['preferredDate']),
  preferredTime = nativeFromJson<String>(json['preferredTime']),
  mode = nativeFromJson<String>(json['mode']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertConsultationRequestVariables otherTyped = other as InsertConsultationRequestVariables;
    return patientId == otherTyped.patientId && 
    healthcareWorkerId == otherTyped.healthcareWorkerId && 
    reason == otherTyped.reason && 
    preferredDate == otherTyped.preferredDate && 
    preferredTime == otherTyped.preferredTime && 
    mode == otherTyped.mode;
    
  }
  @override
  int get hashCode => Object.hashAll([patientId.hashCode, healthcareWorkerId.hashCode, reason.hashCode, preferredDate.hashCode, preferredTime.hashCode, mode.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['patientId'] = nativeToJson<String>(patientId);
    json['healthcareWorkerId'] = nativeToJson<String>(healthcareWorkerId);
    json['reason'] = nativeToJson<String>(reason);
    json['preferredDate'] = nativeToJson<DateTime>(preferredDate);
    json['preferredTime'] = nativeToJson<String>(preferredTime);
    json['mode'] = nativeToJson<String>(mode);
    return json;
  }

  InsertConsultationRequestVariables({
    required this.patientId,
    required this.healthcareWorkerId,
    required this.reason,
    required this.preferredDate,
    required this.preferredTime,
    required this.mode,
  });
}

