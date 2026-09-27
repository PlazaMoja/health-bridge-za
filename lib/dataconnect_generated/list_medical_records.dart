part of 'generated.dart';

class ListMedicalRecordsVariablesBuilder {
  String patientId;

  final FirebaseDataConnect _dataConnect;
  ListMedicalRecordsVariablesBuilder(this._dataConnect, {required  this.patientId,});
  Deserializer<ListMedicalRecordsData> dataDeserializer = (dynamic json)  => ListMedicalRecordsData.fromJson(jsonDecode(json));
  Serializer<ListMedicalRecordsVariables> varsSerializer = (ListMedicalRecordsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListMedicalRecordsData, ListMedicalRecordsVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListMedicalRecordsData, ListMedicalRecordsVariables> ref() {
    ListMedicalRecordsVariables vars= ListMedicalRecordsVariables(patientId: patientId,);
    return _dataConnect.query("ListMedicalRecords", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListMedicalRecordsMedicalRecords {
  final String id;
  final DateTime visitDate;
  final String? diagnosis;
  final String? notes;
  final ListMedicalRecordsMedicalRecordsClinic clinic;
  ListMedicalRecordsMedicalRecords.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  visitDate = nativeFromJson<DateTime>(json['visitDate']),
  diagnosis = json['diagnosis'] == null ? null : nativeFromJson<String>(json['diagnosis']),
  notes = json['notes'] == null ? null : nativeFromJson<String>(json['notes']),
  clinic = ListMedicalRecordsMedicalRecordsClinic.fromJson(json['clinic']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMedicalRecordsMedicalRecords otherTyped = other as ListMedicalRecordsMedicalRecords;
    return id == otherTyped.id && 
    visitDate == otherTyped.visitDate && 
    diagnosis == otherTyped.diagnosis && 
    notes == otherTyped.notes && 
    clinic == otherTyped.clinic;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, visitDate.hashCode, diagnosis.hashCode, notes.hashCode, clinic.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['visitDate'] = nativeToJson<DateTime>(visitDate);
    if (diagnosis != null) {
      json['diagnosis'] = nativeToJson<String?>(diagnosis);
    }
    if (notes != null) {
      json['notes'] = nativeToJson<String?>(notes);
    }
    json['clinic'] = clinic.toJson();
    return json;
  }

  ListMedicalRecordsMedicalRecords({
    required this.id,
    required this.visitDate,
    this.diagnosis,
    this.notes,
    required this.clinic,
  });
}

@immutable
class ListMedicalRecordsMedicalRecordsClinic {
  final String name;
  ListMedicalRecordsMedicalRecordsClinic.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMedicalRecordsMedicalRecordsClinic otherTyped = other as ListMedicalRecordsMedicalRecordsClinic;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  ListMedicalRecordsMedicalRecordsClinic({
    required this.name,
  });
}

@immutable
class ListMedicalRecordsData {
  final List<ListMedicalRecordsMedicalRecords> medicalRecords;
  ListMedicalRecordsData.fromJson(dynamic json):
  
  medicalRecords = (json['medicalRecords'] as List<dynamic>)
        .map((e) => ListMedicalRecordsMedicalRecords.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMedicalRecordsData otherTyped = other as ListMedicalRecordsData;
    return medicalRecords == otherTyped.medicalRecords;
    
  }
  @override
  int get hashCode => medicalRecords.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['medicalRecords'] = medicalRecords.map((e) => e.toJson()).toList();
    return json;
  }

  ListMedicalRecordsData({
    required this.medicalRecords,
  });
}

@immutable
class ListMedicalRecordsVariables {
  final String patientId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListMedicalRecordsVariables.fromJson(Map<String, dynamic> json):
  
  patientId = nativeFromJson<String>(json['patientId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMedicalRecordsVariables otherTyped = other as ListMedicalRecordsVariables;
    return patientId == otherTyped.patientId;
    
  }
  @override
  int get hashCode => patientId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['patientId'] = nativeToJson<String>(patientId);
    return json;
  }

  ListMedicalRecordsVariables({
    required this.patientId,
  });
}

