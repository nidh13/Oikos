RegExp regExpName = RegExp(
  r'(^[a-zA-Z0-9 ]*$)',
);
RegExp regExpEmail = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$",
);
RegExp regExpPassword = RegExp(
  r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$",
);
RegExp regExpNumber = RegExp(
  r'^\d+(?:\.\d+)?$',
);
Pattern passwordPattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
Pattern emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
Pattern namePattern = r'(^[a-zA-Z0-9 ]*$)';
Pattern _alpha = r'^[a-zA-Z]+$';
Pattern specialCharacterPatter =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)';
Pattern numberPatten = r'^(?:[+0]9)?[0-9]{10}$';
RegExp _numeric = RegExp(r'^-?[0-9]+$');
Pattern onedigit = r'^(?=.*?[0-9])';
Pattern uppercasePattern = r'^(?=.*[A-Z])';
Pattern specialCaracPattern = r'^(?=.*?[!@#\$&*~]).{8,}$';
class ValidName{
  bool valid;
  String message;
  ValidName({
    this.valid,
    this.message
});
}
ValidName validfNameMessage(String value,String labelName) {
  RegExp regex = new RegExp(_alpha);
  if (value == null) {
    return ValidName(valid: false,message: '');
  } else if (value.isEmpty) {
    return ValidName(valid: false,message: "Le champ "+labelName+" est vide");
  } else if (!regex.hasMatch(value.toString())) {
    return ValidName(valid: false,message: "Le champ "+labelName+" contient que de lettre");
  }
  return ValidName(valid: true,message: 'ok');
}
ValidName validEmailMessage(String value,String labelName) {
  RegExp regex = new RegExp(emailPattern);
  if (value == null) {
    return ValidName(valid: false,message: '');
  } else if (value.isEmpty) {
    return ValidName(valid: false,message: "Le champ "+labelName+" est vide");
  } else if (!regex.hasMatch(value.toString())) {
    return ValidName(valid: false,message: "Invalide Email");
  }
  return ValidName(valid: true,message: 'ok');
}
ValidName validAddressMessage(String value,String labelName) {
  if (value == null) {
    return ValidName(valid: false,message: '');
  } else if (value.isEmpty) {
    return ValidName(valid: false,message: "Le champ "+labelName+" est vide");
  }
  return ValidName(valid: true,message: 'ok');
}
ValidName validZipCodeMessage(String value,String labelName) {
  RegExp regex = new RegExp(r'^-?[0-9]+$');
  if (value == null) {
    return ValidName(valid: false,message: '');
  } else if (value.isEmpty) {
    return ValidName(valid: false,message: "Le champ "+labelName+" est vide");
  } else if (!regex.hasMatch(value.toString())) {
    return ValidName(valid: false,message: "Le champ "+labelName+" contient que de numéros");
  }
  return ValidName(valid: true,message: 'ok');
}
