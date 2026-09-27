part of 'generated.dart';

class ListClinicsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListClinicsVariablesBuilder(this._dataConnect, );
  Deserializer<ListClinicsData> dataDeserializer = (dynamic json)  => ListClinicsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListClinicsData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListClinicsData, void> ref() {
    
    return _dataConnect.query("ListClinics", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListClinicsClinics {
  final String id;
  final String name;
  final String province;
  final String municipality;
  final bool isActive;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? phoneNumber;
  final String? openingTime;
  final String? closingTime;
  ListClinicsClinics.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  province = nativeFromJson<String>(json['province']),
  municipality = nativeFromJson<String>(json['municipality']),
  isActive = nativeFromJson<bool>(json['isActive']),
  address = json['address'] == null ? null : nativeFromJson<String>(json['address']),
  latitude = json['latitude'] == null ? null : nativeFromJson<double>(json['latitude']),
  longitude = json['longitude'] == null ? null : nativeFromJson<double>(json['longitude']),
  phoneNumber = json['phoneNumber'] == null ? null : nativeFromJson<String>(json['phoneNumber']),
  openingTime = json['openingTime'] == null ? null : nativeFromJson<String>(json['openingTime']),
  closingTime = json['closingTime'] == null ? null : nativeFromJson<String>(json['closingTime']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListClinicsClinics otherTyped = other as ListClinicsClinics;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    province == otherTyped.province && 
    municipality == otherTyped.municipality && 
    isActive == otherTyped.isActive && 
    address == otherTyped.address && 
    latitude == otherTyped.latitude && 
    longitude == otherTyped.longitude && 
    phoneNumber == otherTyped.phoneNumber && 
    openingTime == otherTyped.openingTime && 
    closingTime == otherTyped.closingTime;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, province.hashCode, municipality.hashCode, isActive.hashCode, address.hashCode, latitude.hashCode, longitude.hashCode, phoneNumber.hashCode, openingTime.hashCode, closingTime.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['province'] = nativeToJson<String>(province);
    json['municipality'] = nativeToJson<String>(municipality);
    json['isActive'] = nativeToJson<bool>(isActive);
    if (address != null) {
      json['address'] = nativeToJson<String?>(address);
    }
    if (latitude != null) {
      json['latitude'] = nativeToJson<double?>(latitude);
    }
    if (longitude != null) {
      json['longitude'] = nativeToJson<double?>(longitude);
    }
    if (phoneNumber != null) {
      json['phoneNumber'] = nativeToJson<String?>(phoneNumber);
    }
    if (openingTime != null) {
      json['openingTime'] = nativeToJson<String?>(openingTime);
    }
    if (closingTime != null) {
      json['closingTime'] = nativeToJson<String?>(closingTime);
    }
    return json;
  }

  ListClinicsClinics({
    required this.id,
    required this.name,
    required this.province,
    required this.municipality,
    required this.isActive,
    this.address,
    this.latitude,
    this.longitude,
    this.phoneNumber,
    this.openingTime,
    this.closingTime,
  });
}

@immutable
class ListClinicsData {
  final List<ListClinicsClinics> clinics;
  ListClinicsData.fromJson(dynamic json):
  
  clinics = (json['clinics'] as List<dynamic>)
        .map((e) => ListClinicsClinics.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListClinicsData otherTyped = other as ListClinicsData;
    return clinics == otherTyped.clinics;
    
  }
  @override
  int get hashCode => clinics.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['clinics'] = clinics.map((e) => e.toJson()).toList();
    return json;
  }

  ListClinicsData({
    required this.clinics,
  });
}

