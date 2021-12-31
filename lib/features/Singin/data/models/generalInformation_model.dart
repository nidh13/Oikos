class GeneralInformationModel {
  String birthDate;
  String maritalStatus;
  String civility;
  Address address;

  GeneralInformationModel(
      {this.birthDate, this.maritalStatus, this.civility, this.address});

  GeneralInformationModel.fromJson(Map<String, dynamic> json) {
    birthDate = json['birthDate'];
    maritalStatus = json['maritalStatus'];
    civility = json['civility'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthDate'] = this.birthDate;
    data['maritalStatus'] = this.maritalStatus;
    data['civility'] = this.civility;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}

class Address {
  String street;
  String zipCode;
  int departmentIdentifier;

  Address({this.street, this.zipCode, this.departmentIdentifier});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    zipCode = json['zipCode'];
    departmentIdentifier = json['departmentIdentifier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['zipCode'] = this.zipCode;
    data['departmentIdentifier'] = this.departmentIdentifier;
    return data;
  }
}