part of 'generated.dart';

class ListHealthcareWorkersVariablesBuilder {
  String clinicId;

  final FirebaseDataConnect _dataConnect;
  ListHealthcareWorkersVariablesBuilder(this._dataConnect, {required  this.clinicId,});
  Deserializer<ListHealthcareWorkersData> dataDeserializer = (dynamic json)  => ListHealthcareWorkersData.fromJson(jsonDecode(json));
  Serializer<ListHealthcareWorkersVariables> varsSerializer = (ListHealthcareWorkersVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListHealthcareWorkersData, ListHealthcareWorkersVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListHealthcareWorkersData, ListHealthcareWorkersVariables> ref() {
    ListHealthcareWorkersVariables vars= ListHealthcareWorkersVariables(clinicId: clinicId,);
    return _dataConnect.query("ListHealthcareWorkers", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListHealthcareWorkersHealthcareWorkers {
  final String id;
  final ListHealthcareWorkersHealthcareWorkersUser user;
  final String? profession;
  final String? specialization;
  final bool? isActive;
  ListHealthcareWorkersHealthcareWorkers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  user = ListHealthcareWorkersHealthcareWorkersUser.fromJson(json['user']),
  profession = json['profession'] == null ? null : nativeFromJson<String>(json['profession']),
  specialization = json['specialization'] == null ? null : nativeFromJson<String>(json['specialization']),
  isActive = json['isActive'] == null ? null : nativeFromJson<bool>(json['isActive']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListHealthcareWorkersHealthcareWorkers otherTyped = other as ListHealthcareWorkersHealthcareWorkers;
    return id == otherTyped.id && 
    user == otherTyped.user && 
    profession == otherTyped.profession && 
    specialization == otherTyped.specialization && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, user.hashCode, profession.hashCode, specialization.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['user'] = user.toJson();
    if (profession != null) {
      json['profession'] = nativeToJson<String?>(profession);
    }
    if (specialization != null) {
      json['specialization'] = nativeToJson<String?>(specialization);
    }
    if (isActive != null) {
      json['isActive'] = nativeToJson<bool?>(isActive);
    }
    return json;
  }

  ListHealthcareWorkersHealthcareWorkers({
    required this.id,
    required this.user,
    this.profession,
    this.specialization,
    this.isActive,
  });
}

@immutable
class ListHealthcareWorkersHealthcareWorkersUser {
  final String firstName;
  final String lastName;
  ListHealthcareWorkersHealthcareWorkersUser.fromJson(dynamic json):
  
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

    final ListHealthcareWorkersHealthcareWorkersUser otherTyped = other as ListHealthcareWorkersHealthcareWorkersUser;
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

  ListHealthcareWorkersHealthcareWorkersUser({
    required this.firstName,
    required this.lastName,
  });
}

@immutable
class ListHealthcareWorkersData {
  final List<ListHealthcareWorkersHealthcareWorkers> healthcareWorkers;
  ListHealthcareWorkersData.fromJson(dynamic json):
  
  healthcareWorkers = (json['healthcareWorkers'] as List<dynamic>)
        .map((e) => ListHealthcareWorkersHealthcareWorkers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListHealthcareWorkersData otherTyped = other as ListHealthcareWorkersData;
    return healthcareWorkers == otherTyped.healthcareWorkers;
    
  }
  @override
  int get hashCode => healthcareWorkers.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['healthcareWorkers'] = healthcareWorkers.map((e) => e.toJson()).toList();
    return json;
  }

  ListHealthcareWorkersData({
    required this.healthcareWorkers,
  });
}

@immutable
class ListHealthcareWorkersVariables {
  final String clinicId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListHealthcareWorkersVariables.fromJson(Map<String, dynamic> json):
  
  clinicId = nativeFromJson<String>(json['clinicId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListHealthcareWorkersVariables otherTyped = other as ListHealthcareWorkersVariables;
    return clinicId == otherTyped.clinicId;
    
  }
  @override
  int get hashCode => clinicId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['clinicId'] = nativeToJson<String>(clinicId);
    return json;
  }

  ListHealthcareWorkersVariables({
    required this.clinicId,
  });
}

