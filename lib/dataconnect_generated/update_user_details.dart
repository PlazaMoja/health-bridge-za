part of 'generated.dart';

class UpdateUserDetailsVariablesBuilder {
  String id;
  String firstName;
  String lastName;
  Optional<String> _phoneNumber = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateUserDetailsVariablesBuilder phoneNumber(String? t) {
   _phoneNumber.value = t;
   return this;
  }

  UpdateUserDetailsVariablesBuilder(this._dataConnect, {required  this.id,required  this.firstName,required  this.lastName,});
  Deserializer<UpdateUserDetailsData> dataDeserializer = (dynamic json)  => UpdateUserDetailsData.fromJson(jsonDecode(json));
  Serializer<UpdateUserDetailsVariables> varsSerializer = (UpdateUserDetailsVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateUserDetailsData, UpdateUserDetailsVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateUserDetailsData, UpdateUserDetailsVariables> ref() {
    UpdateUserDetailsVariables vars= UpdateUserDetailsVariables(id: id,firstName: firstName,lastName: lastName,phoneNumber: _phoneNumber,);
    return _dataConnect.mutation("UpdateUserDetails", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateUserDetailsUserUpdate {
  final String id;
  UpdateUserDetailsUserUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserDetailsUserUpdate otherTyped = other as UpdateUserDetailsUserUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateUserDetailsUserUpdate({
    required this.id,
  });
}

@immutable
class UpdateUserDetailsData {
  final UpdateUserDetailsUserUpdate? user_update;
  UpdateUserDetailsData.fromJson(dynamic json):
  
  user_update = json['user_update'] == null ? null : UpdateUserDetailsUserUpdate.fromJson(json['user_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserDetailsData otherTyped = other as UpdateUserDetailsData;
    return user_update == otherTyped.user_update;
    
  }
  @override
  int get hashCode => user_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user_update != null) {
      json['user_update'] = user_update!.toJson();
    }
    return json;
  }

  UpdateUserDetailsData({
    this.user_update,
  });
}

@immutable
class UpdateUserDetailsVariables {
  final String id;
  final String firstName;
  final String lastName;
  late final Optional<String>phoneNumber;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateUserDetailsVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  firstName = nativeFromJson<String>(json['firstName']),
  lastName = nativeFromJson<String>(json['lastName']) {
  
  
  
  
  
    phoneNumber = Optional.optional(nativeFromJson, nativeToJson);
    phoneNumber.value = json['phoneNumber'] == null ? null : nativeFromJson<String>(json['phoneNumber']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserDetailsVariables otherTyped = other as UpdateUserDetailsVariables;
    return id == otherTyped.id && 
    firstName == otherTyped.firstName && 
    lastName == otherTyped.lastName && 
    phoneNumber == otherTyped.phoneNumber;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, firstName.hashCode, lastName.hashCode, phoneNumber.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['firstName'] = nativeToJson<String>(firstName);
    json['lastName'] = nativeToJson<String>(lastName);
    if(phoneNumber.state == OptionalState.set) {
      json['phoneNumber'] = phoneNumber.toJson();
    }
    return json;
  }

  UpdateUserDetailsVariables({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });
}

