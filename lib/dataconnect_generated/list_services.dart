part of 'generated.dart';

class ListServicesVariablesBuilder {
  String clinicId;

  final FirebaseDataConnect _dataConnect;
  ListServicesVariablesBuilder(this._dataConnect, {required  this.clinicId,});
  Deserializer<ListServicesData> dataDeserializer = (dynamic json)  => ListServicesData.fromJson(jsonDecode(json));
  Serializer<ListServicesVariables> varsSerializer = (ListServicesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListServicesData, ListServicesVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListServicesData, ListServicesVariables> ref() {
    ListServicesVariables vars= ListServicesVariables(clinicId: clinicId,);
    return _dataConnect.query("ListServices", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListServicesServices {
  final String id;
  final String name;
  ListServicesServices.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListServicesServices otherTyped = other as ListServicesServices;
    return id == otherTyped.id && 
    name == otherTyped.name;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  ListServicesServices({
    required this.id,
    required this.name,
  });
}

@immutable
class ListServicesData {
  final List<ListServicesServices> services;
  ListServicesData.fromJson(dynamic json):
  
  services = (json['services'] as List<dynamic>)
        .map((e) => ListServicesServices.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListServicesData otherTyped = other as ListServicesData;
    return services == otherTyped.services;
    
  }
  @override
  int get hashCode => services.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['services'] = services.map((e) => e.toJson()).toList();
    return json;
  }

  ListServicesData({
    required this.services,
  });
}

@immutable
class ListServicesVariables {
  final String clinicId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListServicesVariables.fromJson(Map<String, dynamic> json):
  
  clinicId = nativeFromJson<String>(json['clinicId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListServicesVariables otherTyped = other as ListServicesVariables;
    return clinicId == otherTyped.clinicId;
    
  }
  @override
  int get hashCode => clinicId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['clinicId'] = nativeToJson<String>(clinicId);
    return json;
  }

  ListServicesVariables({
    required this.clinicId,
  });
}

