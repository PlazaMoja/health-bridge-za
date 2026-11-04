part of 'generated.dart';

class ListMedicationsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMedicationsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMedicationsData> dataDeserializer = (dynamic json)  => ListMedicationsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMedicationsData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListMedicationsData, void> ref() {
    
    return _dataConnect.query("ListMedications", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMedicationsMedications {
  final String id;
  final String name;
  final String? type;
  final String category;
  final double price;
  ListMedicationsMedications.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  type = json['type'] == null ? null : nativeFromJson<String>(json['type']),
  category = nativeFromJson<String>(json['category']),
  price = nativeFromJson<double>(json['price']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMedicationsMedications otherTyped = other as ListMedicationsMedications;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    type == otherTyped.type && 
    category == otherTyped.category && 
    price == otherTyped.price;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, type.hashCode, category.hashCode, price.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    if (type != null) {
      json['type'] = nativeToJson<String?>(type);
    }
    json['category'] = nativeToJson<String>(category);
    json['price'] = nativeToJson<double>(price);
    return json;
  }

  ListMedicationsMedications({
    required this.id,
    required this.name,
    this.type,
    required this.category,
    required this.price,
  });
}

@immutable
class ListMedicationsData {
  final List<ListMedicationsMedications> medications;
  ListMedicationsData.fromJson(dynamic json):
  
  medications = (json['medications'] as List<dynamic>)
        .map((e) => ListMedicationsMedications.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMedicationsData otherTyped = other as ListMedicationsData;
    return medications == otherTyped.medications;
    
  }
  @override
  int get hashCode => medications.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['medications'] = medications.map((e) => e.toJson()).toList();
    return json;
  }

  ListMedicationsData({
    required this.medications,
  });
}

