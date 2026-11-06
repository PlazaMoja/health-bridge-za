part of 'generated.dart';

class DeletePatientAccountVariablesBuilder {
  String userId;
  String patientId;

  final FirebaseDataConnect _dataConnect;
  DeletePatientAccountVariablesBuilder(this._dataConnect, {required  this.userId,required  this.patientId,});
  Deserializer<DeletePatientAccountData> dataDeserializer = (dynamic json)  => DeletePatientAccountData.fromJson(jsonDecode(json));
  Serializer<DeletePatientAccountVariables> varsSerializer = (DeletePatientAccountVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeletePatientAccountData, DeletePatientAccountVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeletePatientAccountData, DeletePatientAccountVariables> ref() {
    DeletePatientAccountVariables vars= DeletePatientAccountVariables(userId: userId,patientId: patientId,);
    return _dataConnect.mutation("DeletePatientAccount", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeletePatientAccountPatientDelete {
  final String id;
  DeletePatientAccountPatientDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletePatientAccountPatientDelete otherTyped = other as DeletePatientAccountPatientDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletePatientAccountPatientDelete({
    required this.id,
  });
}

@immutable
class DeletePatientAccountUserDelete {
  final String id;
  DeletePatientAccountUserDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletePatientAccountUserDelete otherTyped = other as DeletePatientAccountUserDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeletePatientAccountUserDelete({
    required this.id,
  });
}

@immutable
class DeletePatientAccountData {
  final int medicationOrderItem_deleteMany;
  final int medicationOrder_deleteMany;
  final int consultationRequest_deleteMany;
  final int medicalRecord_deleteMany;
  final int appointment_deleteMany;
  final int preference_deleteMany;
  final DeletePatientAccountPatientDelete? patient_delete;
  final DeletePatientAccountUserDelete? user_delete;
  DeletePatientAccountData.fromJson(dynamic json):
  
  medicationOrderItem_deleteMany = nativeFromJson<int>(json['medicationOrderItem_deleteMany']),
  medicationOrder_deleteMany = nativeFromJson<int>(json['medicationOrder_deleteMany']),
  consultationRequest_deleteMany = nativeFromJson<int>(json['consultationRequest_deleteMany']),
  medicalRecord_deleteMany = nativeFromJson<int>(json['medicalRecord_deleteMany']),
  appointment_deleteMany = nativeFromJson<int>(json['appointment_deleteMany']),
  preference_deleteMany = nativeFromJson<int>(json['preference_deleteMany']),
  patient_delete = json['patient_delete'] == null ? null : DeletePatientAccountPatientDelete.fromJson(json['patient_delete']),
  user_delete = json['user_delete'] == null ? null : DeletePatientAccountUserDelete.fromJson(json['user_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletePatientAccountData otherTyped = other as DeletePatientAccountData;
    return medicationOrderItem_deleteMany == otherTyped.medicationOrderItem_deleteMany && 
    medicationOrder_deleteMany == otherTyped.medicationOrder_deleteMany && 
    consultationRequest_deleteMany == otherTyped.consultationRequest_deleteMany && 
    medicalRecord_deleteMany == otherTyped.medicalRecord_deleteMany && 
    appointment_deleteMany == otherTyped.appointment_deleteMany && 
    preference_deleteMany == otherTyped.preference_deleteMany && 
    patient_delete == otherTyped.patient_delete && 
    user_delete == otherTyped.user_delete;
    
  }
  @override
  int get hashCode => Object.hashAll([medicationOrderItem_deleteMany.hashCode, medicationOrder_deleteMany.hashCode, consultationRequest_deleteMany.hashCode, medicalRecord_deleteMany.hashCode, appointment_deleteMany.hashCode, preference_deleteMany.hashCode, patient_delete.hashCode, user_delete.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['medicationOrderItem_deleteMany'] = nativeToJson<int>(medicationOrderItem_deleteMany);
    json['medicationOrder_deleteMany'] = nativeToJson<int>(medicationOrder_deleteMany);
    json['consultationRequest_deleteMany'] = nativeToJson<int>(consultationRequest_deleteMany);
    json['medicalRecord_deleteMany'] = nativeToJson<int>(medicalRecord_deleteMany);
    json['appointment_deleteMany'] = nativeToJson<int>(appointment_deleteMany);
    json['preference_deleteMany'] = nativeToJson<int>(preference_deleteMany);
    if (patient_delete != null) {
      json['patient_delete'] = patient_delete!.toJson();
    }
    if (user_delete != null) {
      json['user_delete'] = user_delete!.toJson();
    }
    return json;
  }

  DeletePatientAccountData({
    required this.medicationOrderItem_deleteMany,
    required this.medicationOrder_deleteMany,
    required this.consultationRequest_deleteMany,
    required this.medicalRecord_deleteMany,
    required this.appointment_deleteMany,
    required this.preference_deleteMany,
    this.patient_delete,
    this.user_delete,
  });
}

@immutable
class DeletePatientAccountVariables {
  final String userId;
  final String patientId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeletePatientAccountVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']),
  patientId = nativeFromJson<String>(json['patientId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeletePatientAccountVariables otherTyped = other as DeletePatientAccountVariables;
    return userId == otherTyped.userId && 
    patientId == otherTyped.patientId;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, patientId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['patientId'] = nativeToJson<String>(patientId);
    return json;
  }

  DeletePatientAccountVariables({
    required this.userId,
    required this.patientId,
  });
}

