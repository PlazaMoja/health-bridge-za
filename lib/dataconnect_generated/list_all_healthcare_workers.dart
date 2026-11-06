part of 'generated.dart';

class ListAllHealthcareWorkersVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListAllHealthcareWorkersVariablesBuilder(this._dataConnect, );
  Deserializer<ListAllHealthcareWorkersData> dataDeserializer = (dynamic json)  => ListAllHealthcareWorkersData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListAllHealthcareWorkersData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListAllHealthcareWorkersData, void> ref() {
    
    return _dataConnect.query("ListAllHealthcareWorkers", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListAllHealthcareWorkersHealthcareWorkers {
  final String id;
  final ListAllHealthcareWorkersHealthcareWorkersUser user;
  final String? profession;
  final String? specialization;
  final bool? isActive;
  final ListAllHealthcareWorkersHealthcareWorkersClinic clinic;
  ListAllHealthcareWorkersHealthcareWorkers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  user = ListAllHealthcareWorkersHealthcareWorkersUser.fromJson(json['user']),
  profession = json['profession'] == null ? null : nativeFromJson<String>(json['profession']),
  specialization = json['specialization'] == null ? null : nativeFromJson<String>(json['specialization']),
  isActive = json['isActive'] == null ? null : nativeFromJson<bool>(json['isActive']),
  clinic = ListAllHealthcareWorkersHealthcareWorkersClinic.fromJson(json['clinic']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllHealthcareWorkersHealthcareWorkers otherTyped = other as ListAllHealthcareWorkersHealthcareWorkers;
    return id == otherTyped.id && 
    user == otherTyped.user && 
    profession == otherTyped.profession && 
    specialization == otherTyped.specialization && 
    isActive == otherTyped.isActive && 
    clinic == otherTyped.clinic;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, user.hashCode, profession.hashCode, specialization.hashCode, isActive.hashCode, clinic.hashCode]);
  

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
    json['clinic'] = clinic.toJson();
    return json;
  }

  ListAllHealthcareWorkersHealthcareWorkers({
    required this.id,
    required this.user,
    this.profession,
    this.specialization,
    this.isActive,
    required this.clinic,
  });
}

@immutable
class ListAllHealthcareWorkersHealthcareWorkersUser {
  final String firstName;
  final String lastName;
  ListAllHealthcareWorkersHealthcareWorkersUser.fromJson(dynamic json):
  
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

    final ListAllHealthcareWorkersHealthcareWorkersUser otherTyped = other as ListAllHealthcareWorkersHealthcareWorkersUser;
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

  ListAllHealthcareWorkersHealthcareWorkersUser({
    required this.firstName,
    required this.lastName,
  });
}

@immutable
class ListAllHealthcareWorkersHealthcareWorkersClinic {
  final String name;
  ListAllHealthcareWorkersHealthcareWorkersClinic.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllHealthcareWorkersHealthcareWorkersClinic otherTyped = other as ListAllHealthcareWorkersHealthcareWorkersClinic;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  ListAllHealthcareWorkersHealthcareWorkersClinic({
    required this.name,
  });
}

@immutable
class ListAllHealthcareWorkersData {
  final List<ListAllHealthcareWorkersHealthcareWorkers> healthcareWorkers;
  ListAllHealthcareWorkersData.fromJson(dynamic json):
  
  healthcareWorkers = (json['healthcareWorkers'] as List<dynamic>)
        .map((e) => ListAllHealthcareWorkersHealthcareWorkers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllHealthcareWorkersData otherTyped = other as ListAllHealthcareWorkersData;
    return healthcareWorkers == otherTyped.healthcareWorkers;
    
  }
  @override
  int get hashCode => healthcareWorkers.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['healthcareWorkers'] = healthcareWorkers.map((e) => e.toJson()).toList();
    return json;
  }

  ListAllHealthcareWorkersData({
    required this.healthcareWorkers,
  });
}

