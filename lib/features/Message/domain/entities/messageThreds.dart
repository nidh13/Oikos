import 'package:oikosmobile/features/Message/domain/entities/messageThread.dart';
import 'package:oikosmobile/features/Singin/data/models/profile_model.dart';
import 'package:oikosmobile/features/Singin/domain/entities/user.dart';

class MessageThreads {
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
  List<MessageThread> listMessageThread=[];
  List<User> users=[];
  MessageThreads(
      {this.totalPages,
        this.totalElements,
        this.size,
        this.content,
        this.number,
        this.sort,
        this.numberOfElements,
        this.pageable,
        this.first,
        this.last,
        this.empty,this.users,this.listMessageThread});

  MessageThreads.fromJson(Map<String, dynamic> json) {
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
  String recipientID;
  String dateLastMessage;

  Content({this.id, this.recipientID, this.dateLastMessage});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recipientID = json['recipientID'];
    dateLastMessage = json['dateLastMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['recipientID'] = this.recipientID;
    data['dateLastMessage'] = this.dateLastMessage;
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