part of 'generated.dart';

class UpdatePatientDetailsVariablesBuilder {
  String id;
  Optional<DateTime> _dateOfBirth = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _gender = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _address = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _emergencyContactName = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _emergencyContactPhone = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdatePatientDetailsVariablesBuilder dateOfBirth(DateTime? t) {
   _dateOfBirth.value = t;
   return this;
  }
  UpdatePatientDetailsVariablesBuilder gender(String? t) {
   _gender.value = t;
   return this;
  }
  UpdatePatientDetailsVariablesBuilder address(String? t) {
   _address.value = t;
   return this;
  }
  UpdatePatientDetailsVariablesBuilder emergencyContactName(String? t) {
   _emergencyContactName.value = t;
   return this;
  }
  UpdatePatientDetailsVariablesBuilder emergencyContactPhone(String? t) {
   _emergencyContactPhone.value = t;
   return this;
  }

  UpdatePatientDetailsVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdatePatientDetailsData> dataDeserializer = (dynamic json)  => UpdatePatientDetailsData.fromJson(jsonDecode(json));
  Serializer<UpdatePatientDetailsVariables> varsSerializer = (UpdatePatientDetailsVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdatePatientDetailsData, UpdatePatientDetailsVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdatePatientDetailsData, UpdatePatientDetailsVariables> ref() {
    UpdatePatientDetailsVariables vars= UpdatePatientDetailsVariables(id: id,dateOfBirth: _dateOfBirth,gender: _gender,address: _address,emergencyContactName: _emergencyContactName,emergencyContactPhone: _emergencyContactPhone,);
    return _dataConnect.mutation("UpdatePatientDetails", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdatePatientDetailsPatientUpdate {
  final String id;
  UpdatePatientDetailsPatientUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdatePatientDetailsPatientUpdate otherTyped = other as UpdatePatientDetailsPatientUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdatePatientDetailsPatientUpdate({
    required this.id,
  });
}

@immutable
class UpdatePatientDetailsData {
  final UpdatePatientDetailsPatientUpdate? patient_update;
  UpdatePatientDetailsData.fromJson(dynamic json):
  
  patient_update = json['patient_update'] == null ? null : UpdatePatientDetailsPatientUpdate.fromJson(json['patient_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdatePatientDetailsData otherTyped = other as UpdatePatientDetailsData;
    return patient_update == otherTyped.patient_update;
    
  }
  @override
  int get hashCode => patient_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (patient_update != null) {
      json['patient_update'] = patient_update!.toJson();
    }
    return json;
  }

  UpdatePatientDetailsData({
    this.patient_update,
  });
}

@immutable
class UpdatePatientDetailsVariables {
  final String id;
  late final Optional<DateTime>dateOfBirth;
  late final Optional<String>gender;
  late final Optional<String>address;
  late final Optional<String>emergencyContactName;
  late final Optional<String>emergencyContactPhone;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdatePatientDetailsVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    dateOfBirth = Optional.optional(nativeFromJson, nativeToJson);
    dateOfBirth.value = json['dateOfBirth'] == null ? null : nativeFromJson<DateTime>(json['dateOfBirth']);
  
  
    gender = Optional.optional(nativeFromJson, nativeToJson);
    gender.value = json['gender'] == null ? null : nativeFromJson<String>(json['gender']);
  
  
    address = Optional.optional(nativeFromJson, nativeToJson);
    address.value = json['address'] == null ? null : nativeFromJson<String>(json['address']);
  
  
    emergencyContactName = Optional.optional(nativeFromJson, nativeToJson);
    emergencyContactName.value = json['emergencyContactName'] == null ? null : nativeFromJson<String>(json['emergencyContactName']);
  
  
    emergencyContactPhone = Optional.optional(nativeFromJson, nativeToJson);
    emergencyContactPhone.value = json['emergencyContactPhone'] == null ? null : nativeFromJson<String>(json['emergencyContactPhone']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdatePatientDetailsVariables otherTyped = other as UpdatePatientDetailsVariables;
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
    if(dateOfBirth.state == OptionalState.set) {
      json['dateOfBirth'] = dateOfBirth.toJson();
    }
    if(gender.state == OptionalState.set) {
      json['gender'] = gender.toJson();
    }
    if(address.state == OptionalState.set) {
      json['address'] = address.toJson();
    }
    if(emergencyContactName.state == OptionalState.set) {
      json['emergencyContactName'] = emergencyContactName.toJson();
    }
    if(emergencyContactPhone.state == OptionalState.set) {
      json['emergencyContactPhone'] = emergencyContactPhone.toJson();
    }
    return json;
  }

  UpdatePatientDetailsVariables({
    required this.id,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
  });
}

