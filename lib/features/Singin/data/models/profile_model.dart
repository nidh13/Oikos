class ProfileModel {
  String id;
  List<String> roles;
  String email;
  String phoneNumber;
  String provider;
  String firstName;
  String lastName;
  String createdAt;
  String maritalStatus;
  String civility;
  Address address;
  String birthDate;
  bool validated;
  UserProfileFileInfo userProfileFileInfo;

  ProfileModel(
      {this.id,
        this.roles,
        this.email,
        this.phoneNumber,
        this.provider,
        this.firstName,
        this.lastName,
        this.createdAt,
        this.maritalStatus,
        this.civility,
        this.address,
        this.birthDate,
        this.validated,
        this.userProfileFileInfo});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roles = json['roles'].cast<String>();
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    provider = json['provider'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    createdAt = json['createdAt'];
    maritalStatus = json['maritalStatus'];
    civility = json['civility'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    birthDate = json['birthDate'];
    validated = json['validated'];
    userProfileFileInfo = json['userProfileFileInfo'] != null
        ? new UserProfileFileInfo.fromJson(json['userProfileFileInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roles'] = this.roles;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['provider'] = this.provider;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['createdAt'] = this.createdAt;
    data['maritalStatus'] = this.maritalStatus;
    data['civility'] = this.civility;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['birthDate'] = this.birthDate;
    data['validated'] = this.validated;
    if (this.userProfileFileInfo != null) {
      data['userProfileFileInfo'] = this.userProfileFileInfo.toJson();
    }
    return data;
  }
}

class Address {
  String street;
  String zipCode;
  String departmentName;

  Address({this.street, this.zipCode, this.departmentName});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    zipCode = json['zipCode'];
    departmentName = json['departmentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['zipCode'] = this.zipCode;
    data['departmentName'] = this.departmentName;
    return data;
  }
}

class UserProfileFileInfo {
  String fileName;
  String fileType;
  String originalFileName;
  int size;

  UserProfileFileInfo(
      {this.fileName, this.fileType, this.originalFileName, this.size});

  UserProfileFileInfo.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    fileType = json['fileType'];
    originalFileName = json['originalFileName'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['fileType'] = this.fileType;
    data['originalFileName'] = this.originalFileName;
    data['size'] = this.size;
    return data;
  }
}
