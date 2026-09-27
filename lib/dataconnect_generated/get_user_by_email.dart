part of 'generated.dart';

class GetUserByEmailVariablesBuilder {
  String email;

  final FirebaseDataConnect _dataConnect;
  GetUserByEmailVariablesBuilder(this._dataConnect, {required  this.email,});
  Deserializer<GetUserByEmailData> dataDeserializer = (dynamic json)  => GetUserByEmailData.fromJson(jsonDecode(json));
  Serializer<GetUserByEmailVariables> varsSerializer = (GetUserByEmailVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserByEmailData, GetUserByEmailVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetUserByEmailData, GetUserByEmailVariables> ref() {
    GetUserByEmailVariables vars= GetUserByEmailVariables(email: email,);
    return _dataConnect.query("GetUserByEmail", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetUserByEmailUsers {
  final String firebaseUid;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String role;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  GetUserByEmailUsers.fromJson(dynamic json):
  
  firebaseUid = nativeFromJson<String>(json['firebaseUid']),
  email = nativeFromJson<String>(json['email']),
  firstName = nativeFromJson<String>(json['firstName']),
  lastName = nativeFromJson<String>(json['lastName']),
  phoneNumber = json['phoneNumber'] == null ? null : nativeFromJson<String>(json['phoneNumber']),
  role = nativeFromJson<String>(json['role']),
  createdAt = json['createdAt'] == null ? null : Timestamp.fromJson(json['createdAt']),
  updatedAt = json['updatedAt'] == null ? null : Timestamp.fromJson(json['updatedAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByEmailUsers otherTyped = other as GetUserByEmailUsers;
    return firebaseUid == otherTyped.firebaseUid && 
    email == otherTyped.email && 
    firstName == otherTyped.firstName && 
    lastName == otherTyped.lastName && 
    phoneNumber == otherTyped.phoneNumber && 
    role == otherTyped.role && 
    createdAt == otherTyped.createdAt && 
    updatedAt == otherTyped.updatedAt;
    
  }
  @override
  int get hashCode => Object.hashAll([firebaseUid.hashCode, email.hashCode, firstName.hashCode, lastName.hashCode, phoneNumber.hashCode, role.hashCode, createdAt.hashCode, updatedAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['firebaseUid'] = nativeToJson<String>(firebaseUid);
    json['email'] = nativeToJson<String>(email);
    json['firstName'] = nativeToJson<String>(firstName);
    json['lastName'] = nativeToJson<String>(lastName);
    if (phoneNumber != null) {
      json['phoneNumber'] = nativeToJson<String?>(phoneNumber);
    }
    json['role'] = nativeToJson<String>(role);
    if (createdAt != null) {
      json['createdAt'] = createdAt!.toJson();
    }
    if (updatedAt != null) {
      json['updatedAt'] = updatedAt!.toJson();
    }
    return json;
  }

  GetUserByEmailUsers({
    required this.firebaseUid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.role,
    this.createdAt,
    this.updatedAt,
  });
}

@immutable
class GetUserByEmailData {
  final List<GetUserByEmailUsers> users;
  GetUserByEmailData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => GetUserByEmailUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByEmailData otherTyped = other as GetUserByEmailData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  GetUserByEmailData({
    required this.users,
  });
}

@immutable
class GetUserByEmailVariables {
  final String email;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserByEmailVariables.fromJson(Map<String, dynamic> json):
  
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByEmailVariables otherTyped = other as GetUserByEmailVariables;
    return email == otherTyped.email;
    
  }
  @override
  int get hashCode => email.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  GetUserByEmailVariables({
    required this.email,
  });
}

