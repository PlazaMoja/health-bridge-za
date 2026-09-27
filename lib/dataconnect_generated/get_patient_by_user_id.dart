part of 'generated.dart';

class GetPatientByUserIdVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetPatientByUserIdVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetPatientByUserIdData> dataDeserializer = (dynamic json)  => GetPatientByUserIdData.fromJson(jsonDecode(json));
  Serializer<GetPatientByUserIdVariables> varsSerializer = (GetPatientByUserIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetPatientByUserIdData, GetPatientByUserIdVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetPatientByUserIdData, GetPatientByUserIdVariables> ref() {
    GetPatientByUserIdVariables vars= GetPatientByUserIdVariables(userId: userId,);
    return _dataConnect.query("GetPatientByUserId", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetPatientByUserIdPatient {
  final String id;
  GetPatientByUserIdPatient.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPatientByUserIdPatient otherTyped = other as GetPatientByUserIdPatient;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetPatientByUserIdPatient({
    required this.id,
  });
}

@immutable
class GetPatientByUserIdData {
  final GetPatientByUserIdPatient? patient;
  GetPatientByUserIdData.fromJson(dynamic json):
  
  patient = json['patient'] == null ? null : GetPatientByUserIdPatient.fromJson(json['patient']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPatientByUserIdData otherTyped = other as GetPatientByUserIdData;
    return patient == otherTyped.patient;
    
  }
  @override
  int get hashCode => patient.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (patient != null) {
      json['patient'] = patient!.toJson();
    }
    return json;
  }

  GetPatientByUserIdData({
    this.patient,
  });
}

@immutable
class GetPatientByUserIdVariables {
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetPatientByUserIdVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPatientByUserIdVariables otherTyped = other as GetPatientByUserIdVariables;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetPatientByUserIdVariables({
    required this.userId,
  });
}

