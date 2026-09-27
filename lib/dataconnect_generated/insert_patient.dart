part of 'generated.dart';

class InsertPatientVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  InsertPatientVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<InsertPatientData> dataDeserializer = (dynamic json)  => InsertPatientData.fromJson(jsonDecode(json));
  Serializer<InsertPatientVariables> varsSerializer = (InsertPatientVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertPatientData, InsertPatientVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertPatientData, InsertPatientVariables> ref() {
    InsertPatientVariables vars= InsertPatientVariables(userId: userId,);
    return _dataConnect.mutation("InsertPatient", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertPatientPatientInsert {
  final String id;
  InsertPatientPatientInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertPatientPatientInsert otherTyped = other as InsertPatientPatientInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertPatientPatientInsert({
    required this.id,
  });
}

@immutable
class InsertPatientData {
  final InsertPatientPatientInsert patient_insert;
  InsertPatientData.fromJson(dynamic json):
  
  patient_insert = InsertPatientPatientInsert.fromJson(json['patient_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertPatientData otherTyped = other as InsertPatientData;
    return patient_insert == otherTyped.patient_insert;
    
  }
  @override
  int get hashCode => patient_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['patient_insert'] = patient_insert.toJson();
    return json;
  }

  InsertPatientData({
    required this.patient_insert,
  });
}

@immutable
class InsertPatientVariables {
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertPatientVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertPatientVariables otherTyped = other as InsertPatientVariables;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  InsertPatientVariables({
    required this.userId,
  });
}

