part of 'generated.dart';

class InsertUserVariablesBuilder {
  String firebaseUid;
  String email;
  String firstName;
  String lastName;
  Optional<String> _phoneNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _role = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  InsertUserVariablesBuilder phoneNumber(String? t) {
   _phoneNumber.value = t;
   return this;
  }
  InsertUserVariablesBuilder role(String? t) {
   _role.value = t;
   return this;
  }

  InsertUserVariablesBuilder(this._dataConnect, {required  this.firebaseUid,required  this.email,required  this.firstName,required  this.lastName,});
  Deserializer<InsertUserData> dataDeserializer = (dynamic json)  => InsertUserData.fromJson(jsonDecode(json));
  Serializer<InsertUserVariables> varsSerializer = (InsertUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertUserData, InsertUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertUserData, InsertUserVariables> ref() {
    InsertUserVariables vars= InsertUserVariables(firebaseUid: firebaseUid,email: email,firstName: firstName,lastName: lastName,phoneNumber: _phoneNumber,role: _role,);
    return _dataConnect.mutation("InsertUser", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertUserUserInsert {
  final String id;
  InsertUserUserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertUserUserInsert otherTyped = other as InsertUserUserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertUserUserInsert({
    required this.id,
  });
}

@immutable
class InsertUserData {
  final InsertUserUserInsert user_insert;
  InsertUserData.fromJson(dynamic json):
  
  user_insert = InsertUserUserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertUserData otherTyped = other as InsertUserData;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  InsertUserData({
    required this.user_insert,
  });
}

@immutable
class InsertUserVariables {
  final String firebaseUid;
  final String email;
  final String firstName;
  final String lastName;
  late final Optional<String>phoneNumber;
  late final Optional<String>role;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertUserVariables.fromJson(Map<String, dynamic> json):
  
  firebaseUid = nativeFromJson<String>(json['firebaseUid']),
  email = nativeFromJson<String>(json['email']),
  firstName = nativeFromJson<String>(json['firstName']),
  lastName = nativeFromJson<String>(json['lastName']) {
  
  
  
  
  
  
    phoneNumber = Optional.optional(nativeFromJson, nativeToJson);
    phoneNumber.value = json['phoneNumber'] == null ? null : nativeFromJson<String>(json['phoneNumber']);
  
  
    role = Optional.optional(nativeFromJson, nativeToJson);
    role.value = json['role'] == null ? null : nativeFromJson<String>(json['role']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertUserVariables otherTyped = other as InsertUserVariables;
    return firebaseUid == otherTyped.firebaseUid && 
    email == otherTyped.email && 
    firstName == otherTyped.firstName && 
    lastName == otherTyped.lastName && 
    phoneNumber == otherTyped.phoneNumber && 
    role == otherTyped.role;
    
  }
  @override
  int get hashCode => Object.hashAll([firebaseUid.hashCode, email.hashCode, firstName.hashCode, lastName.hashCode, phoneNumber.hashCode, role.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['firebaseUid'] = nativeToJson<String>(firebaseUid);
    json['email'] = nativeToJson<String>(email);
    json['firstName'] = nativeToJson<String>(firstName);
    json['lastName'] = nativeToJson<String>(lastName);
    if(phoneNumber.state == OptionalState.set) {
      json['phoneNumber'] = phoneNumber.toJson();
    }
    if(role.state == OptionalState.set) {
      json['role'] = role.toJson();
    }
    return json;
  }

  InsertUserVariables({
    required this.firebaseUid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.role,
  });
}

