class MessageThread {
  String id;
  int totalPages;
  int totalElements;
  int size;
  List<Content> content;
  int number;
  Sort sort;
  int numberOfElements;
  Pageable pageable;
  bool first;
  bool last;
  bool empty;

  MessageThread(
      {this.id,this.totalPages,
        this.totalElements,
        this.size,
        this.content,
        this.number,
        this.sort,
        this.numberOfElements,
        this.pageable,
        this.first,
        this.last,
        this.empty});

  MessageThread.fromJson(Map<String, dynamic> json) {
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    size = json['size'];
    if (json['content'] != null) {
      content = new List<Content>();
      json['content'].forEach((v) {
        content.add(new Content.fromJson(v));
      });
    }
    number = json['number'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    numberOfElements = json['numberOfElements'];
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    first = json['first'];
    last = json['last'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['size'] = this.size;
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['number'] = this.number;
    if (this.sort != null) {
      data['sort'] = this.sort.toJson();
    }
    data['numberOfElements'] = this.numberOfElements;
    if (this.pageable != null) {
      data['pageable'] = this.pageable.toJson();
    }
    data['first'] = this.first;
    data['last'] = this.last;
    data['empty'] = this.empty;
    return data;
  }
}

class Content {
  String id;
  String senderId;
  String recipientId;
  String threadId;
  String status;
  String updatedAt;
  String createdAt;
  String content;
  MessageAttachement messageAttachement;

  Content(
      {this.id,
        this.senderId,
        this.recipientId,
        this.threadId,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.content,
        this.messageAttachement});

  Content.fromJson(Map<String, dynamic> json) {
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

class Sort {
  bool sorted;
  bool unsorted;
  bool empty;

  Sort({this.sorted, this.unsorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sorted'] = this.sorted;
    data['unsorted'] = this.unsorted;
    data['empty'] = this.empty;
    return data;
  }
}

class Pageable {
  int page;
  int size;

  Pageable({this.page, this.size});

  Pageable.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['size'] = this.size;
    return data;
  }
}