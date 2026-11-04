part of 'generated.dart';

class GetPatientProfileVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetPatientProfileVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetPatientProfileData> dataDeserializer = (dynamic json)  => GetPatientProfileData.fromJson(jsonDecode(json));
  Serializer<GetPatientProfileVariables> varsSerializer = (GetPatientProfileVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetPatientProfileData, GetPatientProfileVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetPatientProfileData, GetPatientProfileVariables> ref() {
    GetPatientProfileVariables vars= GetPatientProfileVariables(userId: userId,);
    return _dataConnect.query("GetPatientProfile", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetPatientProfilePatient {
  final String id;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? address;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  GetPatientProfilePatient.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  dateOfBirth = json['dateOfBirth'] == null ? null : nativeFromJson<DateTime>(json['dateOfBirth']),
  gender = json['gender'] == null ? null : nativeFromJson<String>(json['gender']),
  address = json['address'] == null ? null : nativeFromJson<String>(json['address']),
  emergencyContactName = json['emergencyContactName'] == null ? null : nativeFromJson<String>(json['emergencyContactName']),
  emergencyContactPhone = json['emergencyContactPhone'] == null ? null : nativeFromJson<String>(json['emergencyContactPhone']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPatientProfilePatient otherTyped = other as GetPatientProfilePatient;
    return id == otherTyped.id && 
    dateOfBirth == otherTyped.dateOfBirth && 
    gender == otherTyped.gender && 
    address == otherTyped.address && 
    emergencyContactName == otherTyped.emergencyContactName && 
    emergencyContactPhone == otherTyped.emergencyContactPhone;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, dateOfBirth.hashCode, gender.hashCode, address.hashCode, emergencyContactName.hashCode, emergencyContactPhone.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (dateOfBirth != null) {
      json['dateOfBirth'] = nativeToJson<DateTime?>(dateOfBirth);
    }
    if (gender != null) {
      json['gender'] = nativeToJson<String?>(gender);
    }
    if (address != null) {
      json['address'] = nativeToJson<String?>(address);
    }
    if (emergencyContactName != null) {
      json['emergencyContactName'] = nativeToJson<String?>(emergencyContactName);
    }
    if (emergencyContactPhone != null) {
      json['emergencyContactPhone'] = nativeToJson<String?>(emergencyContactPhone);
    }
    return json;
  }

  GetPatientProfilePatient({
    required this.id,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.emergencyContactName,
    this.emergencyContactPhone,
  });
}

@immutable
class GetPatientProfileData {
  final GetPatientProfilePatient? patient;
  GetPatientProfileData.fromJson(dynamic json):
  
  patient = json['patient'] == null ? null : GetPatientProfilePatient.fromJson(json['patient']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPatientProfileData otherTyped = other as GetPatientProfileData;
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

  GetPatientProfileData({
    this.patient,
  });
}

@immutable
class GetPatientProfileVariables {
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetPatientProfileVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPatientProfileVariables otherTyped = other as GetPatientProfileVariables;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetPatientProfileVariables({
    required this.userId,
  });
}

