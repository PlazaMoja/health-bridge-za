part of 'generated.dart';

class ListConsultationRequestsVariablesBuilder {
  String patientId;

  final FirebaseDataConnect _dataConnect;
  ListConsultationRequestsVariablesBuilder(this._dataConnect, {required  this.patientId,});
  Deserializer<ListConsultationRequestsData> dataDeserializer = (dynamic json)  => ListConsultationRequestsData.fromJson(jsonDecode(json));
  Serializer<ListConsultationRequestsVariables> varsSerializer = (ListConsultationRequestsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListConsultationRequestsData, ListConsultationRequestsVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListConsultationRequestsData, ListConsultationRequestsVariables> ref() {
    ListConsultationRequestsVariables vars= ListConsultationRequestsVariables(patientId: patientId,);
    return _dataConnect.query("ListConsultationRequests", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListConsultationRequestsConsultationRequests {
  final String id;
  final String reason;
  final DateTime preferredDate;
  final String preferredTime;
  final String mode;
  final String status;
  final Timestamp? createdAt;
  final ListConsultationRequestsConsultationRequestsHealthcareWorker healthcareWorker;
  ListConsultationRequestsConsultationRequests.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  reason = nativeFromJson<String>(json['reason']),
  preferredDate = nativeFromJson<DateTime>(json['preferredDate']),
  preferredTime = nativeFromJson<String>(json['preferredTime']),
  mode = nativeFromJson<String>(json['mode']),
  status = nativeFromJson<String>(json['status']),
  createdAt = json['createdAt'] == null ? null : Timestamp.fromJson(json['createdAt']),
  healthcareWorker = ListConsultationRequestsConsultationRequestsHealthcareWorker.fromJson(json['healthcareWorker']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListConsultationRequestsConsultationRequests otherTyped = other as ListConsultationRequestsConsultationRequests;
    return id == otherTyped.id && 
    reason == otherTyped.reason && 
    preferredDate == otherTyped.preferredDate && 
    preferredTime == otherTyped.preferredTime && 
    mode == otherTyped.mode && 
    status == otherTyped.status && 
    createdAt == otherTyped.createdAt && 
    healthcareWorker == otherTyped.healthcareWorker;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, reason.hashCode, preferredDate.hashCode, preferredTime.hashCode, mode.hashCode, status.hashCode, createdAt.hashCode, healthcareWorker.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['reason'] = nativeToJson<String>(reason);
    json['preferredDate'] = nativeToJson<DateTime>(preferredDate);
    json['preferredTime'] = nativeToJson<String>(preferredTime);
    json['mode'] = nativeToJson<String>(mode);
    json['status'] = nativeToJson<String>(status);
    if (createdAt != null) {
      json['createdAt'] = createdAt!.toJson();
    }
    json['healthcareWorker'] = healthcareWorker.toJson();
    return json;
  }

  ListConsultationRequestsConsultationRequests({
    required this.id,
    required this.reason,
    required this.preferredDate,
    required this.preferredTime,
    required this.mode,
    required this.status,
    this.createdAt,
    required this.healthcareWorker,
  });
}

@immutable
class ListConsultationRequestsConsultationRequestsHealthcareWorker {
  final String? profession;
  final String? specialization;
  final ListConsultationRequestsConsultationRequestsHealthcareWorkerUser user;
  final ListConsultationRequestsConsultationRequestsHealthcareWorkerClinic clinic;
  ListConsultationRequestsConsultationRequestsHealthcareWorker.fromJson(dynamic json):
  
  profession = json['profession'] == null ? null : nativeFromJson<String>(json['profession']),
  specialization = json['specialization'] == null ? null : nativeFromJson<String>(json['specialization']),
  user = ListConsultationRequestsConsultationRequestsHealthcareWorkerUser.fromJson(json['user']),
  clinic = ListConsultationRequestsConsultationRequestsHealthcareWorkerClinic.fromJson(json['clinic']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListConsultationRequestsConsultationRequestsHealthcareWorker otherTyped = other as ListConsultationRequestsConsultationRequestsHealthcareWorker;
    return profession == otherTyped.profession && 
    specialization == otherTyped.specialization && 
    user == otherTyped.user && 
    clinic == otherTyped.clinic;
    
  }
  @override
  int get hashCode => Object.hashAll([profession.hashCode, specialization.hashCode, user.hashCode, clinic.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (profession != null) {
      json['profession'] = nativeToJson<String?>(profession);
    }
    if (specialization != null) {
      json['specialization'] = nativeToJson<String?>(specialization);
    }
    json['user'] = user.toJson();
    json['clinic'] = clinic.toJson();
    return json;
  }

  ListConsultationRequestsConsultationRequestsHealthcareWorker({
    this.profession,
    this.specialization,
    required this.user,
    required this.clinic,
  });
}

@immutable
class ListConsultationRequestsConsultationRequestsHealthcareWorkerUser {
  final String firstName;
  final String lastName;
  ListConsultationRequestsConsultationRequestsHealthcareWorkerUser.fromJson(dynamic json):
  
  firstName = nativeFromJson<String>(json['firstName']),
  lastName = nativeFromJson<String>(json['lastName']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListConsultationRequestsConsultationRequestsHealthcareWorkerUser otherTyped = other as ListConsultationRequestsConsultationRequestsHealthcareWorkerUser;
    return firstName == otherTyped.firstName && 
    lastName == otherTyped.lastName;
    
  }
  @override
  int get hashCode => Object.hashAll([firstName.hashCode, lastName.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['firstName'] = nativeToJson<String>(firstName);
    json['lastName'] = nativeToJson<String>(lastName);
    return json;
  }

  ListConsultationRequestsConsultationRequestsHealthcareWorkerUser({
    required this.firstName,
    required this.lastName,
  });
}

@immutable
class ListConsultationRequestsConsultationRequestsHealthcareWorkerClinic {
  final String name;
  final String? phoneNumber;
  ListConsultationRequestsConsultationRequestsHealthcareWorkerClinic.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']),
  phoneNumber = json['phoneNumber'] == null ? null : nativeFromJson<String>(json['phoneNumber']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListConsultationRequestsConsultationRequestsHealthcareWorkerClinic otherTyped = other as ListConsultationRequestsConsultationRequestsHealthcareWorkerClinic;
    return name == otherTyped.name && 
    phoneNumber == otherTyped.phoneNumber;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, phoneNumber.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    if (phoneNumber != null) {
      json['phoneNumber'] = nativeToJson<String?>(phoneNumber);
    }
    return json;
  }

  ListConsultationRequestsConsultationRequestsHealthcareWorkerClinic({
    required this.name,
    this.phoneNumber,
  });
}

@immutable
class ListConsultationRequestsData {
  final List<ListConsultationRequestsConsultationRequests> consultationRequests;
  ListConsultationRequestsData.fromJson(dynamic json):
  
  consultationRequests = (json['consultationRequests'] as List<dynamic>)
        .map((e) => ListConsultationRequestsConsultationRequests.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListConsultationRequestsData otherTyped = other as ListConsultationRequestsData;
    return consultationRequests == otherTyped.consultationRequests;
    
  }
  @override
  int get hashCode => consultationRequests.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['consultationRequests'] = consultationRequests.map((e) => e.toJson()).toList();
    return json;
  }

  ListConsultationRequestsData({
    required this.consultationRequests,
  });
}

@immutable
class ListConsultationRequestsVariables {
  final String patientId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListConsultationRequestsVariables.fromJson(Map<String, dynamic> json):
  
  patientId = nativeFromJson<String>(json['patientId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListConsultationRequestsVariables otherTyped = other as ListConsultationRequestsVariables;
    return patientId == otherTyped.patientId;
    
  }
  @override
  int get hashCode => patientId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['patientId'] = nativeToJson<String>(patientId);
    return json;
  }

  ListConsultationRequestsVariables({
    required this.patientId,
  });
}

