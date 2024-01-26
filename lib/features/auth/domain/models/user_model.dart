/// expiresOn : "2024-01-26T10:07:30.156435347Z"
/// token : "d98f1cdbff8d160dd89524a162898b6e"
/// user : {"_id":"65b1de4c918aad8a3560abcc","email":"test.mobile@gmail.com","firstName":"Test","lastName":"Mobile","phoneNumber":"08973847563","role":["authenticated"]}
/// userId : "65b1de4c918aad8a3560abcc"

class UserModel {
  UserModel({
      String? expiresOn, 
      String? token, 
      User? user, 
      String? userId,}){
    _expiresOn = expiresOn;
    _token = token;
    _user = user;
    _userId = userId;
}

  UserModel.fromJson(dynamic json) {
    _expiresOn = json['expiresOn'];
    _token = json['token'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _userId = json['userId'];
  }
  String? _expiresOn;
  String? _token;
  User? _user;
  String? _userId;
UserModel copyWith({  String? expiresOn,
  String? token,
  User? user,
  String? userId,
}) => UserModel(  expiresOn: expiresOn ?? _expiresOn,
  token: token ?? _token,
  user: user ?? _user,
  userId: userId ?? _userId,
);
  String? get expiresOn => _expiresOn;
  String? get token => _token;
  User? get user => _user;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['expiresOn'] = _expiresOn;
    map['token'] = _token;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['userId'] = _userId;
    return map;
  }

}

/// _id : "65b1de4c918aad8a3560abcc"
/// email : "test.mobile@gmail.com"
/// firstName : "Test"
/// lastName : "Mobile"
/// phoneNumber : "08973847563"
/// role : ["authenticated"]

class User {
  User({
      String? id, 
      String? email, 
      String? firstName, 
      String? lastName, 
      String? phoneNumber, 
      List<String>? role,}){
    _id = id;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _phoneNumber = phoneNumber;
    _role = role;
}

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _email = json['email'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _phoneNumber = json['phoneNumber'];
    _role = json['role'] != null ? json['role'].cast<String>() : [];
  }
  String? _id;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _phoneNumber;
  List<String>? _role;
User copyWith({  String? id,
  String? email,
  String? firstName,
  String? lastName,
  String? phoneNumber,
  List<String>? role,
}) => User(  id: id ?? _id,
  email: email ?? _email,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  phoneNumber: phoneNumber ?? _phoneNumber,
  role: role ?? _role,
);
  String? get id => _id;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get phoneNumber => _phoneNumber;
  List<String>? get role => _role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['email'] = _email;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['phoneNumber'] = _phoneNumber;
    map['role'] = _role;
    return map;
  }

}