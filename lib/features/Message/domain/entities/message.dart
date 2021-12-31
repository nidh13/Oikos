class Message {
  String id;
  String senderId;
  String recipientId;
  String threadId;
  String status;
  String updatedAt;
  String createdAt;
  String content;
  MessageAttachement messageAttachement;

  Message(
      {this.id,
        this.senderId,
        this.recipientId,
        this.threadId,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.content,
        this.messageAttachement});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    recipientId = json['recipientId'];
    threadId = json['threadId'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    content = json['content'];
    messageAttachement = json['messageAttachement'] != null
        ? new MessageAttachement.fromJson(json['messageAttachement'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['senderId'] = this.senderId;
    data['recipientId'] = this.recipientId;
    data['threadId'] = this.threadId;
    data['status'] = this.status;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['content'] = this.content;
    if (this.messageAttachement != null) {
      data['messageAttachement'] = this.messageAttachement.toJson();
    }
    return data;
  }
}

class MessageAttachement {
  String fileName;
  String fileType;
  String originalFileName;
  int size;

  MessageAttachement(
      {this.fileName, this.fileType, this.originalFileName, this.size});

  MessageAttachement.fromJson(Map<String, dynamic> json) {
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