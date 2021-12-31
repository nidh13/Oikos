class UserPicture {
  String fileName;
  String fileType;
  String originalFileName;
  int size;

  UserPicture({this.fileName, this.fileType, this.originalFileName, this.size});

  UserPicture.fromJson(Map<String, dynamic> json) {
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